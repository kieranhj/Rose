// Dump the reference interpreter's plot list as binary ground truth for
// verifying the BBC Micro engine. Each plot is 5 little-endian int16s:
// t, x, y, r, c — in the interpreter's emission order.
#include "translate.h"
#include "rose_result.h"
#include <cstdio>
#include <cstdlib>

int main(int argc, char *argv[]) {
	if (argc < 3) { fprintf(stderr, "usage: roseplots <file.rose> <out.bin> [frames]\n"); return 1; }
	int frames = argc > 3 ? atoi(argv[3]) : 10000;
	RoseResult r = translate(argv[1], frames, 352, 280, 1, 4);
	if (r.error) { fprintf(stderr, "translate error\n"); return 1; }
	FILE *f = fopen(argv[2], "wb");
	for (auto &p : r.plots) {
		short v[5] = { p.t, p.x, p.y, p.r, p.c };
		fwrite(v, 2, 5, f);
	}
	fclose(f);
	int maxr = 0;
	for (auto &p : r.plots) if (p.r > maxr) maxr = p.r;
	printf("PLOTS %d\n", (int)r.plots.size());
	printf("MAXRADIUS %d\n", maxr);
	return 0;
}
