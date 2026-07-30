#pragma once

// Rose Nano — a BBC Model B render mode for the visualizer.
//
// Nano (bbc/docs/rose-nano-v1.md) is a separate language and compiler targeting
// a stock BBC Model B in MODE 2.  Since bbc/docs/rose-nano-v1.md §7 aligned the
// spelling, most `.nano` sources parse as Rose unchanged — but parsing is the
// easy half.  Four things about Nano survive parsing and would make a plain
// Rose preview quietly disagree with the machine:
//
//   grid      a turtle draws whole 2x4-pixel cells, not circles at pixel
//             precision, and the blob is a table of cell radii
//   tint      Nano masks tint to 3 bits; rain and stress both rely on the wrap
//   aspect    MODE 2 pixels are 2:1, so Nano halves dx to keep motion isotropic
//   pool      48 turtle slots, and a full pool drops forks silently
//
// This mode emulates the first three exactly and *reports* the fourth (see
// `pool_peak` below for why).  The point is a preview that fails the same way
// the machine does; a preview that quietly succeeds where the machine fails is
// worse than no preview at all.
//
//   ROSE_NANO=1  ROSE_NANOGRID=80x64|40x32
//
// Default (ROSE_NANO unset) leaves the interpreter bit-identical.

#include <cmath>
#include <cstdlib>
#include <cstring>
#include <cstdio>

struct NanoConfig {
	bool on = false;
	int xsh = 1;         // pixel x >> xsh is the grid column
	int ysh = 2;         // scanline y >> ysh is the grid row
	int nsize = 8;       // blob sizes are masked to this many

	// The MODE 2 canvas, fixed: 160x256 at 4bpp is the whole 20480-byte screen.
	static const int W = 160;
	static const int H = 256;

	// Nano's own constants, matched so an un-`jump`ed turtle starts where the
	// machine starts it (runtime.asm .init).
	static const int START_X = 80;
	static const int START_Y = 128;
	static const int MAXT = 48;

	// Diagnostics: how often the program asked for something Nano cannot do.
	long long n_draw = 0, wrap_tint = 0, wrap_size = 0;
	int pool_peak = 0;

	void init() {
		const char *e = getenv("ROSE_NANO");
		on = e && atoi(e) != 0;
		// NANOGRID is what nanoc.py and verify.sh already read, so honour it
		// too: one variable should not mean the grid to one half of the
		// toolchain and nothing to the other.
		const char *g = getenv("ROSE_NANOGRID");
		if (!g || !*g) g = getenv("NANOGRID");
		if (g && strcmp(g, "40x32") == 0) {
			xsh = 2; ysh = 3; nsize = 4;
		} else {
			xsh = 1; ysh = 2; nsize = 8;
		}
		n_draw = wrap_tint = wrap_size = 0;
		pool_peak = 0;
	}

	int gw() const { return W >> xsh; }
	int gh() const { return H >> ysh; }
	int cellw() const { return 1 << xsh; }
	int cellh() const { return 1 << ysh; }

	// Nano wraps x toroidally on every move and y is a byte, so both axes wrap;
	// see runtime.asm .tmove ("y needs no wrap: the rows divide 256 exactly").
	static inline int wrapx(int px) { return ((px % W) + W) % W; }
	static inline int wrapy(int px) { return px & (H - 1); }

	// The centre of the cell a pixel position falls in.  Snapping here rather
	// than in the renderer means the *plot list* records what the machine would
	// have drawn, so -o output and the on-screen preview cannot drift apart.
	inline int snapx(int px) const {
		return ((wrapx(px) >> xsh) << xsh) + (cellw() >> 1);
	}
	inline int snapy(int px) const {
		return ((wrapy(px) >> ysh) << ysh) + (cellh() >> 1);
	}

	inline int qtint(int t) {
		int m = t & 7;
		if (m != t) wrap_tint++;
		return m;
	}

	// runtime.asm masks rather than clamps (`AND #NSIZE-1`), so size 8 is size 0
	// and draws nothing visible at 80x64.  Matching the mask matters: clamping
	// would silently turn an out-of-range size into the largest blob.
	inline int qsize(int s) {
		n_draw++;
		int m = s & (nsize - 1);
		if (m != s) wrap_size++;
		return m;
	}

	void note_pool(int alive) {
		if (alive > pool_peak) pool_peak = alive;
	}

	// --- colour ------------------------------------------------------------
	// A Nano tint is not an RGB value, it is the best 50/50 dither of two of the
	// eight physical colours (nanoc.py pick_pair, and §2 experiment 4: there are
	// 27 such colours, not 4096).  Showing the *requested* RGB would let an
	// author pick a colour the machine cannot make and only find out on the
	// hardware, so the preview resolves every tint through the same chooser and
	// displays what MODE 2 would actually produce.
	//
	// The dither texture itself is deliberately not drawn: at 1:1 the pair fuses
	// into the mixed colour, which is the entire premise of §13.4, and drawing
	// the checkerboard would only alias against the display scale.
	static double lin1(double x) { return pow(x / 255.0, 2.2); }
	static double unlin1(double x) {
		if (x < 0) x = 0;
		if (x > 1) x = 1;
		return pow(x, 1.0 / 2.2) * 255.0;
	}
	static void rgb24(int v12, double *out) {
		out[0] = ((v12 >> 8) & 15) * 17.0;
		out[1] = ((v12 >> 4) & 15) * 17.0;
		out[2] = (v12 & 15) * 17.0;
	}

	// Returns the 12-bit RGB the machine would show for a 12-bit request.
	static int dither_rgb(int v12) {
		static const int BBC[8] = {0x000, 0xF00, 0x0F0, 0xFF0,
		                           0x00F, 0xF0F, 0x0FF, 0xFFF};
		static const double W[3] = {2.0, 4.0, 3.0};
		const double fuse = 0.02;      // calibrated in nanoc.py; see §8
		double tgt[3];
		rgb24(v12, tgt);
		double bestd = 1e18;
		double bestmix[3] = {0, 0, 0};
		for (int a = 0; a < 8; a++) {
			for (int b = a; b < 8; b++) {
				double ca[3], cb[3], mix[3];
				rgb24(BBC[a], ca);
				rgb24(BBC[b], cb);
				double d = 0;
				for (int i = 0; i < 3; i++) {
					mix[i] = unlin1((lin1(ca[i]) + lin1(cb[i])) / 2.0);
					double e = W[i] * (mix[i] - tgt[i]);
					d += e * e;
				}
				if (a != b) {
					// Without this the chooser picks pairs that do not fuse at
					// a MODE 2 pixel (gold as red+green); §13.4.
					double sep = 0;
					for (int i = 0; i < 3; i++) {
						double e = W[i] * (ca[i] - cb[i]);
						sep += e * e;
					}
					d += fuse * sep;
				}
				if (d < bestd) {
					bestd = d;
					for (int i = 0; i < 3; i++) bestmix[i] = mix[i];
				}
			}
		}
		int out = 0;
		for (int i = 0; i < 3; i++) {
			int q = (int)(bestmix[i] / 17.0 + 0.5);
			if (q < 0) q = 0;
			if (q > 15) q = 15;
			out = (out << 4) | q;
		}
		return out;
	}

	void report(FILE *f) const {
		if (!on) return;
		fprintf(f, "NANO grid %dx%d  cell %dx%d px  sizes 0-%d\n",
			gw(), gh(), cellw(), cellh(), nsize - 1);
		if (wrap_tint) fprintf(f, "NANO_TINT_WRAPPED %lld / %lld draws\n", wrap_tint, n_draw);
		if (wrap_size) fprintf(f, "NANO_SIZE_WRAPPED %lld / %lld draws\n", wrap_size, n_draw);
		if (pool_peak > MAXT) {
			fprintf(f, "NANO_POOL_EXCEEDED peak %d live turtles, Nano has %d slots\n",
				pool_peak, MAXT);
			fprintf(f, "  (the machine would silently drop forks here; this preview does not)\n");
		} else {
			fprintf(f, "NANO_POOL peak %d / %d slots\n", pool_peak, MAXT);
		}
	}
};

extern NanoConfig nano;
