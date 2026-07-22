// Per-frame worst-case analyzer for Rose examples (BBC Micro feasibility).
// Links against the visualizer's translate() and computes, per frame:
//   plots, filled pixels (clipped), MODE-1 bytes touched, scanlines touched.
#include "translate.h"
#include "rose_result.h"
#include <cstdio>
#include <cmath>
#include <vector>
#include <algorithm>

struct FrameAcc {
	int plots = 0;
	long pixels = 0;
	long bytes = 0;   // MODE 1 bytes touched (4 px/byte, per span)
	int lines = 0;    // scanlines touched (per-line overhead proxy)
};

int main(int argc, char *argv[]) {
	if (argc < 2) { fprintf(stderr, "usage: rosestats <file.rose>\n"); return 1; }
	RoseResult r = translate(argv[1], 10000, 352, 280, 1, 4);
	if (r.error) { fprintf(stderr, "translate error\n"); return 1; }

	int W = r.width, H = r.height;
	int frames = 0;
	for (auto &p : r.plots) if (p.t + 1 > frames) frames = p.t + 1;
	std::vector<FrameAcc> acc(frames);

	int max_radius = 0;
	long total_plots = 0;
	std::vector<long> radius_hist(256, 0);

	for (auto &p : r.plots) {
		bool square = p.c < 0;
		int rr = p.r;
		if (rr < 0) continue;
		if (rr > max_radius) max_radius = rr;
		radius_hist[std::min(rr, 255)]++;
		FrameAcc &f = acc[p.t];
		f.plots++;
		total_plots++;
		for (int dy = -rr; dy <= rr; dy++) {
			int y = p.y + dy;
			if (y < 0 || y >= H) continue;
			int hw = square ? rr : (int)floor(sqrt((double)(rr*rr - dy*dy)));
			int x0 = p.x - hw, x1 = p.x + hw;
			if (x1 < 0 || x0 >= W) continue;
			if (x0 < 0) x0 = 0;
			if (x1 >= W) x1 = W - 1;
			f.pixels += x1 - x0 + 1;
			f.bytes += (x1 / 4) - (x0 / 4) + 1;
			f.lines++;
		}
	}

	// Percentile helper over frames that have any plots
	std::vector<int> plotv; std::vector<long> pixv, bytev; std::vector<int> linev;
	for (auto &f : acc) {
		if (f.plots == 0) continue;
		plotv.push_back(f.plots); pixv.push_back(f.pixels);
		bytev.push_back(f.bytes); linev.push_back(f.lines);
	}
	auto pct = [](std::vector<long> v, double p) -> long {
		if (v.empty()) return 0;
		std::sort(v.begin(), v.end());
		size_t i = (size_t)(p * (v.size() - 1));
		return v[i];
	};
	std::vector<long> plotl(plotv.begin(), plotv.end());
	std::vector<long> linel(linev.begin(), linev.end());

	int worst_frame = 0; long worst_bytes = -1;
	for (int i = 0; i < frames; i++)
		if (acc[i].bytes > worst_bytes) { worst_bytes = acc[i].bytes; worst_frame = i; }

	printf("\n#STATS name frames active_frames total_plots max_radius\n");
	printf("#S1 %d %d %ld %d\n", frames, (int)plotv.size(), total_plots, max_radius);
	printf("#STATS metric mean p50 p95 p99 max\n");
	auto mean = [](std::vector<long> &v) -> long {
		if (v.empty()) return 0; long s = 0; for (long x : v) s += x; return s / (long)v.size();
	};
	printf("#S2 plots %ld %ld %ld %ld %ld\n", mean(plotl), pct(plotl,0.5), pct(plotl,0.95), pct(plotl,0.99), pct(plotl,1.0));
	printf("#S2 pixels %ld %ld %ld %ld %ld\n", mean(pixv), pct(pixv,0.5), pct(pixv,0.95), pct(pixv,0.99), pct(pixv,1.0));
	printf("#S2 bytes %ld %ld %ld %ld %ld\n", mean(bytev), pct(bytev,0.5), pct(bytev,0.95), pct(bytev,0.99), pct(bytev,1.0));
	printf("#S2 lines %ld %ld %ld %ld %ld\n", mean(linel), pct(linel,0.5), pct(linel,0.95), pct(linel,0.99), pct(linel,1.0));
	printf("#S3 worst_frame %d plots %d pixels %ld bytes %ld lines %d\n",
		worst_frame, acc[worst_frame].plots, acc[worst_frame].pixels, acc[worst_frame].bytes, acc[worst_frame].lines);

	// Per-frame compute cost (Amiga 68000 cycle estimates from interpret.h) and turtle counts
	if (r.stats) {
		std::vector<long> cpuv, turtv;
		long max_cpu = 0, max_turt = 0; int max_cpu_frame = 0;
		for (int i = 0; i < (int)r.stats->frame.size(); i++) {
			auto &fs = r.stats->frame[i];
			long alive = fs.turtles_survived + fs.turtles_died;
			if (fs.cpu_compute_cycles == 0 && alive == 0) continue;
			cpuv.push_back(fs.cpu_compute_cycles);
			turtv.push_back(alive);
			if (fs.cpu_compute_cycles > max_cpu) { max_cpu = fs.cpu_compute_cycles; max_cpu_frame = i; }
			if (alive > max_turt) max_turt = alive;
		}
		printf("#S5 cpu68k %ld %ld %ld %ld %ld\n", mean(cpuv), pct(cpuv,0.5), pct(cpuv,0.95), pct(cpuv,0.99), pct(cpuv,1.0));
		printf("#S5 turtles %ld %ld %ld %ld %ld\n", mean(turtv), pct(turtv,0.5), pct(turtv,0.95), pct(turtv,0.99), pct(turtv,1.0));
		printf("#S6 worst_cpu_frame %d cycles %ld\n", max_cpu_frame, max_cpu);
	}

	// radius distribution (cumulative)
	long cum = 0;
	printf("#S4 radius_cumulative:");
	for (int i = 0; i <= max_radius; i++) {
		cum += radius_hist[i];
		if (i <= 20 || i == max_radius || (i % 10) == 0)
			printf(" r<=%d:%.1f%%", i, 100.0 * cum / total_plots);
	}
	printf("\n");
	return 0;
}
