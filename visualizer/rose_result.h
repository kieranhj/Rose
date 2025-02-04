#pragma once

#include <vector>
#include <utility>
#include <cstdio>
#include <memory>
#include <string>

struct Plot {
	short t,x,y,r,c;
};

struct TintColor {
	short t,i,rgb;
};

struct RoseResult {
	std::vector<std::string> paths;
	int width, height;
	int layer_count, layer_depth;
	std::vector<Plot> plots;
	std::vector<TintColor> colors;
	std::unique_ptr<struct RoseStatistics> stats;
	bool error;

	bool empty() {
		return plots.empty() && colors.empty();
	}
};

struct FrameStatistics {
	int circles = 0;
	int turtles_survived = 0;
	int turtles_died = 0;

	int cpu_compute_cycles = 0;
	int cpu_draw_cycles = 0;
	int per_wire_cycles = 0;

	int copper_cycles = 0;
	int blitter_cycles = 0;
};

struct RoseStatistics {
	int frames;
	int width, height;
	int layer_count, layer_depth;
	int max_overwait = 0;
	int max_stack_height = 0;
	int wire_capacity = 0;
	int number_of_procedures = 0;
	int number_of_constants = 0;
	int max_radius = 0;
	std::vector<FrameStatistics> frame;

	RoseStatistics(int frames, int width, int height, int layer_count, int layer_depth)
	: frames(frames), width(width), height(height),
	  layer_count(layer_count), layer_depth(layer_depth), frame(frames) {}

	void draw(int f, int x, int y, int size) {
		frame[f].cpu_draw_cycles += 96; // Instruction
		if (x + size < 0) {
			frame[f].cpu_draw_cycles += 30;
			return;
		}
		int vsize = size * 2 + 1;
		if (y - size < 0) {
			vsize = y + size + 1;
			if (vsize < 0) {
				frame[f].cpu_draw_cycles += 42;
				return;
			}
			frame[f].cpu_draw_cycles += 84;
		}
		if (x - size >= width) {
			frame[f].cpu_draw_cycles += 66;
			return;
		}
		if (y + size >= height) {
			vsize = height - y + size;
			if (vsize < 0) {
				frame[f].cpu_draw_cycles += 202;
				return;
			}
			frame[f].cpu_draw_cycles += 10;
		}
		frame[f].cpu_draw_cycles += 320 + 606;

		if (size > max_radius) {
			max_radius = size;
		}

		int hwords = (size >> 3) + 2;
		frame[f].circles += 1;
		frame[f].copper_cycles += 17 * 8;
		frame[f].blitter_cycles += hwords * vsize * 12;
	}

	void print(FILE *out) {
		int max_circles = 0;
		int max_turtles = 0;
		for (int i = 0 ; i < frames ; i++) {
			if (frame[i].circles > max_circles) max_circles = frame[i].circles;
			int turtles_alive = frame[i].turtles_survived + frame[i].turtles_died + 1;
			if (turtles_alive > max_turtles) max_turtles = turtles_alive;
		}
		fprintf(out, "\n");
		fprintf(out, "Number of frames:     %5d\n", frames);
		fprintf(out, "Max extra wait:       %5d\n", max_overwait);
		fprintf(out, "Max circles in frame: %5d\n", max_circles);
		fprintf(out, "Max circle radius:    %5d\n", max_radius);
		fprintf(out, "Max turtles alive:    %5d\n", max_turtles);
		fprintf(out, "Max stack height:     %5d\n", max_stack_height);
		fprintf(out, "Wire capacity:        %5d\n", wire_capacity);
		fprintf(out, "Number of procedures: %5d\n", number_of_procedures);
		fprintf(out, "Number of constants:  %5d\n", number_of_constants);
		fflush(out);
	}
};
