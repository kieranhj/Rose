
#define GLEW_BUILD GLEW_STATIC
#include <GL/glew.h>
#include <GLFW/glfw3.h>

#include <queue>
#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <vector>

#include "translate.h"
#include "renderer.h"
#include "music.h"
#include "filewatch.h"


// --- Minimal PNG writer (uncompressed deflate, no zlib dependency) ---

static uint32_t png_crc_table[256];
static bool png_crc_ready = false;
static void png_init_crc() {
	for (int n = 0; n < 256; n++) {
		uint32_t c = n;
		for (int k = 0; k < 8; k++) c = (c & 1) ? 0xedb88320u ^ (c >> 1) : c >> 1;
		png_crc_table[n] = c;
	}
	png_crc_ready = true;
}
static uint32_t png_crc(const uint8_t* data, size_t len, uint32_t crc = 0xffffffffu) {
	if (!png_crc_ready) png_init_crc();
	for (size_t i = 0; i < len; i++) crc = png_crc_table[(crc ^ data[i]) & 0xff] ^ (crc >> 8);
	return crc ^ 0xffffffffu;
}
static void png_write_chunk(FILE* f, const char type[4], const std::vector<uint8_t>& data) {
	uint32_t len = (uint32_t) data.size();
	auto wb = [&](uint32_t v) { fputc((v>>24)&0xff,f); fputc((v>>16)&0xff,f); fputc((v>>8)&0xff,f); fputc(v&0xff,f); };
	wb(len);
	fwrite(type, 1, 4, f);
	fwrite(data.data(), 1, data.size(), f);
	uint32_t crc = png_crc((const uint8_t*) type, 4);
	crc = png_crc(data.data(), data.size(), crc ^ 0xffffffffu);
	wb(crc);
}

static void save_png(const char* filename, int width, int height, const std::vector<uint8_t>& pixels) {
	// pixels: RGBA, bottom-up (glReadPixels) → flip to top-down for PNG
	FILE* f = fopen(filename, "wb");
	if (!f) { printf("Cannot write to %s\n", filename); return; }

	// PNG signature
	const uint8_t sig[] = {137,80,78,71,13,10,26,10};
	fwrite(sig, 1, 8, f);

	// IHDR
	{
		std::vector<uint8_t> ihdr(13);
		auto wb = [&](int off, uint32_t v) { ihdr[off]=(v>>24)&0xff; ihdr[off+1]=(v>>16)&0xff; ihdr[off+2]=(v>>8)&0xff; ihdr[off+3]=v&0xff; };
		wb(0, width); wb(4, height);
		ihdr[8]=8; ihdr[9]=2; ihdr[10]=0; ihdr[11]=0; ihdr[12]=0; // 8-bit RGB
		png_write_chunk(f, "IHDR", ihdr);
	}

	// Build raw image: filter byte (0) + RGB rows, top-down
	int row_bytes = 1 + width * 3;
	std::vector<uint8_t> raw((size_t) height * row_bytes);
	for (int y = 0; y < height; y++) {
		int src_y = height - 1 - y; // flip
		raw[y * row_bytes] = 0;
		for (int x = 0; x < width; x++) {
			int src = (src_y * width + x) * 4;
			raw[y * row_bytes + 1 + x*3+0] = pixels[src+0];
			raw[y * row_bytes + 1 + x*3+1] = pixels[src+1];
			raw[y * row_bytes + 1 + x*3+2] = pixels[src+2];
		}
	}

	// IDAT: zlib wrapper around uncompressed deflate blocks
	{
		std::vector<uint8_t> idat;
		idat.push_back(0x78); idat.push_back(0x01); // zlib header

		size_t pos = 0, total = raw.size();
		while (pos < total || total == 0) {
			size_t block = std::min((size_t)65535, total - pos);
			bool last = (pos + block >= total);
			idat.push_back(last ? 0x01 : 0x00);
			uint16_t len = (uint16_t) block, nlen = ~len;
			idat.push_back(len & 0xff); idat.push_back(len >> 8);
			idat.push_back(nlen & 0xff); idat.push_back(nlen >> 8);
			idat.insert(idat.end(), raw.begin() + pos, raw.begin() + pos + block);
			pos += block;
			if (total == 0) break;
		}

		// Adler-32 (big-endian)
		uint32_t s1 = 1, s2 = 0;
		for (uint8_t b : raw) { s1 = (s1 + b) % 65521; s2 = (s2 + s1) % 65521; }
		uint32_t adler = (s2 << 16) | s1;
		idat.push_back((adler>>24)&0xff); idat.push_back((adler>>16)&0xff);
		idat.push_back((adler>>8)&0xff);  idat.push_back(adler&0xff);

		png_write_chunk(f, "IDAT", idat);
	}

	// IEND
	png_write_chunk(f, "IEND", {});

	fclose(f);
	printf("Saved %s\n", filename);
}


// Defaults
#define WIDTH 352
#define HEIGHT 280
#define LAYERS 1
#define DEPTH 4
#define WINDOW_SCALE 2
#define FRAMES 10000
#define FRAMERATE 50


void error_callback(int error, const char* description) {
	printf(" *** GLFW error: %s\n", description);
	fflush(stdout);
}

void key_callback(GLFWwindow *window, int key, int scancode, int action, int mods) {
	std::queue<int>* key_queue = (std::queue<int>*) glfwGetWindowUserPointer(window);
	if (action == GLFW_PRESS || action == GLFW_REPEAT) {
		key_queue->push(key);
	}
}

static RoseRenderer* make_renderer(RoseResult rose_data) {
	if (rose_data.empty()) {
		return nullptr;
	}
	return new RoseRenderer(std::move(rose_data), rose_data.width, rose_data.height);
}

class FileWatches {
	std::vector<FileWatch> watches;
	int index = 0;

public:
	FileWatches(const RoseResult& rose_result) {
		for (const std::string& path : rose_result.paths) {
			watches.emplace_back(path.c_str());
		}
	}

	bool changed() {
		for (int i = 0; i < watches.size(); i++) {
			if (watches[i].changed()) {
				index = i;
				return true;
			}
		}
		return false;
	}

	const char* time_text() {
		return watches[index].time_text();
	}
};

int main(int argc, char *argv[]) {
	if (argc < 2) {
		printf("Usage: rose <filename> [x<scale>] [<framerate> [<music>]] [-o <output.bmp>] [-f <N>|<N-M>]\n");
		exit(1);
	}

	// Extract -o and -f flags; build filtered arg list for remaining parsing
	const char* output_file = nullptr;
	int frame_start = 0, frame_end = 0;
	std::vector<const char*> fargs;
	fargs.push_back(argv[0]);
	for (int i = 1; i < argc; i++) {
		if (strcmp(argv[i], "-o") == 0 && i + 1 < argc) {
			output_file = argv[++i];
		} else if (strcmp(argv[i], "-f") == 0 && i + 1 < argc) {
			const char* fspec = argv[++i];
			const char* dash = strchr(fspec, '-');
			if (dash) {
				frame_start = atoi(fspec);
				frame_end   = atoi(dash + 1);
			} else {
				frame_start = frame_end = atoi(fspec);
			}
		} else {
			fargs.push_back(argv[i]);
		}
	}
	int fargc = (int) fargs.size();
	const char** fargv = fargs.data();

	int arg = 1;
	const char* main_filename = fargv[arg++];

	int window_scale = WINDOW_SCALE;
	if (fargc > arg && fargv[arg][0] == 'x') {
		window_scale = atoi(&fargv[arg++][1]);
	}

	int framerate = FRAMERATE;
	if (fargc > arg) {
		framerate = atoi(fargv[arg++]);
	}

	MusicPlayer player;
	int frames = FRAMES;
	if (fargc > arg) {
		if (fargv[arg][0] == '+') {
			frames = atoi(fargv[arg++]+1);
		} else {
			player.load(fargv[arg++]);
			frames = (int) (player.length() * framerate);
		}
	}

	// Load code
	RoseResult rose_result = translate(main_filename, frames, WIDTH, HEIGHT, LAYERS, DEPTH);
	std::unique_ptr<FileWatches> watches(new FileWatches(rose_result));
	int width = rose_result.width;
	int height = rose_result.height;
	// Nano mode renders a 160x256 MODE 2 canvas whose pixels are 2:1, so the
	// texture stays at canvas resolution and the DISPLAY stretches x.  Doing it
	// here rather than in the plot geometry keeps the grid square in memory and
	// crisp on screen (the combine pass magnifies with GL_NEAREST).
	int aspect = rose_result.pixel_aspect;

	// Initialize GLFW
	glfwSetErrorCallback(error_callback);
	glfwInit();

	// Initialize Window
	glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 2);
	glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 0);
	glfwWindowHint(GLFW_RESIZABLE, GL_FALSE);
	if (output_file) glfwWindowHint(GLFW_VISIBLE, GL_FALSE);
	GLFWwindow *window = glfwCreateWindow(width * window_scale * aspect, height * window_scale, "Rose", nullptr, nullptr);
	glfwMakeContextCurrent(window);
	glewExperimental = GL_TRUE;
	glewInit();
	glfwSwapInterval(1);
	glfwSetInputMode(window, GLFW_STICKY_KEYS, GL_TRUE);

	RoseRenderer* project = make_renderer(std::move(rose_result));

	// Headless mode: render frame(s), save BMP(s), exit
	if (output_file) {
		if (project) {
			int ow = width * aspect;
			glViewport(0, 0, ow, height);
			std::vector<uint8_t> pixels(ow * height * 4);
			bool is_sequence = (frame_start != frame_end);
			char path_buf[1024];
			for (int f = frame_start; f <= frame_end; f++) {
				glBindFramebuffer(GL_DRAW_FRAMEBUFFER, 0);
				project->draw(f, false);
				glBindFramebuffer(GL_READ_FRAMEBUFFER, 0);
				glReadPixels(0, 0, ow, height, GL_RGBA, GL_UNSIGNED_BYTE, pixels.data());
				if (is_sequence) {
					snprintf(path_buf, sizeof(path_buf), output_file, f);
					save_png(path_buf, ow, height, pixels);
				} else {
					save_png(output_file, ow, height, pixels);
				}
			}
		} else {
			printf("Compilation failed, no output written.\n");
		}
		if (project) delete project;
		glfwDestroyWindow(window);
		glfwTerminate();
		return project ? 0 : 1;
	}

	// Set up key callback
	std::queue<int> key_queue;
	glfwSetWindowUserPointer(window, &key_queue);
	glfwSetKeyCallback(window, key_callback);

	player.start(0);
	int startframe = 0;
	int frame = 0;
	bool playing = true;
	bool overlay_enabled = false;
	while (glfwGetKey(window, GLFW_KEY_ESCAPE) != GLFW_PRESS && !glfwWindowShouldClose(window)) {
		bool frame_set = false;

		// Reload if changed
		if (watches->changed()) {
			// Reload code
			printf("\nReloading at %s\n", watches->time_text());
			if (project) delete project;
			rose_result = translate(main_filename, frames, WIDTH, HEIGHT, LAYERS, DEPTH);
			if (rose_result.empty() && !rose_result.error) {
				// Try again
				usleep(100*1000);
				rose_result = translate(main_filename, frames, WIDTH, HEIGHT, LAYERS, DEPTH);
			}
			watches.reset(new FileWatches(rose_result));
			fflush(stdout);
			if (playing) {
				frame = startframe;
				frame_set = true;
			}
			project = make_renderer(std::move(rose_result));
			if (project) {
				if (project->width != width || project->height != height) {
					width = project->width;
					height = project->height;
					glfwSetWindowSize(window, width * window_scale * aspect, height * window_scale);
					glViewport(0, 0, width * window_scale * aspect, height * window_scale);
				}
			}
		}

		if (glfwGetMouseButton(window, GLFW_MOUSE_BUTTON_1) == GLFW_PRESS) {
			double xpos,ypos;
			glfwGetCursorPos(window, &xpos, &ypos);
			frame = (int)(xpos / (width * window_scale * aspect) * frames);
			frame_set = true;
			startframe = frame;
		}

		while (!key_queue.empty()) {
			int key = key_queue.front();
			key_queue.pop();
			switch (key) {
			case GLFW_KEY_SPACE:
				playing = !playing;
				if (playing) {
					startframe = frame;
					player.start(frame / (double) framerate);
				} else {
					player.stop();
					frame_set = true;
				}
				break;
			case GLFW_KEY_BACKSPACE:
				frame = startframe;
				frame_set = true;
				break;
			case GLFW_KEY_LEFT:
				frame -= 1;
				frame_set = true;
				break;
			case GLFW_KEY_RIGHT:
				frame += 1;
				frame_set = true;
				break;
			case GLFW_KEY_PAGE_UP:
				frame -= 50;
				frame_set = true;
				break;
			case GLFW_KEY_PAGE_DOWN:
				frame += 50;
				frame_set = true;
				break;
			case GLFW_KEY_HOME:
				frame = 0;
				frame_set = true;
				break;
			case GLFW_KEY_TAB:
				overlay_enabled = !overlay_enabled;
				break;
			}
		}

		// Clamp frame
		if (frame < 0) frame = 0;
		if (frame > frames-1) frame = frames-1;

		if (frame_set) {
			player.set_time(frame / (double) framerate);
		}

		// Render
		glBindFramebuffer(GL_DRAW_FRAMEBUFFER, 0);
		if (project) {
			if (project->draw(frame, overlay_enabled)) {
				glfwSwapBuffers(window);
			}
		} else {
			// Error color
			glClearColor(1,0,0,0);
			glClear(GL_COLOR_BUFFER_BIT);
			glfwSwapBuffers(window);
		}

		glfwPollEvents();

		if (playing && project) {
			int prev_frame = frame;
			do {
				usleep(1000);
				frame = (int)(player.get_time() * framerate);
			} while (frame == prev_frame);
		} else {
			usleep(100000);
		}
	}


	if (project) delete project;

	glfwDestroyWindow(window);

	glfwTerminate();
	return 0;
}

