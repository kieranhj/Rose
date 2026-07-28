#pragma once

// Rose Micro — a reduced numeric model for 8-bit targets (see bbc/docs/rose-micro.md).
//
// The reference interpreter normally computes in 32-bit 16.16 fixed point. On a
// 2MHz 6502 that word width costs roughly a quarter of all interpreter time and
// four times the turtle state. This header lets the same interpreter emulate a
// 16-bit machine so the *artistic* consequences can be judged before any 6502 is
// written:
//
//   position   x,y        10.6 fixed  (range +-512, resolution 1/64 px)
//   direction  8.8 units  (256 units per circle, 1/256 unit accumulation, wraps)
//   sine       SINB-entry table, Q(SINA) amplitude
//   radius     clamped to RMAX (brush model)
//   values     (optional, VALQ) every expression result quantised to VALQ bits
//
// Everything is driven by environment variables so the visualizer, roseplots and
// any other consumer of translate() pick it up identically:
//
//   ROSE_MICRO=1  ROSE_POSQ=6  ROSE_DIRQ=8  ROSE_SINB=8  ROSE_SINA=8
//   ROSE_RMAX=15  ROSE_VALQ=0
//
// Default (ROSE_MICRO unset) is bit-identical to the original interpreter.

#include <cmath>
#include <cstdlib>
#include <cstdio>

struct MicroConfig {
	bool on = false;
	int posq = 6;    // fractional bits of x,y
	int dirq = 8;    // fractional bits of direction (unit = 1/256 circle)
	int sinb = 8;    // sine table index bits
	int sina = 8;    // sine table amplitude bits
	int rmax = 15;   // max draw radius (0 = no clamp)
	int valq = 0;    // fractional bits of general values (0 = leave 16.16)
	int rnd = 0;     // 1 = round to nearest instead of truncating toward -inf

	int sintab[1 << 14];

	// Diagnostics: how often the 16-bit model would have gone out of range.
	long long n_pos = 0, ovf_pos = 0;   // |x|,|y| >= 512
	long long n_val = 0, ovf_val = 0;   // |value| >= 512 with VALQ on
	long long n_mul = 0, ovf_mul = 0;   // multiply result out of 16-bit range
	long long n_draw = 0, clamp_r = 0;  // radius clamped by RMAX

	void init() {
		const char *e = getenv("ROSE_MICRO");
		on = e && atoi(e) != 0;
		geti("ROSE_POSQ", &posq);
		geti("ROSE_DIRQ", &dirq);
		geti("ROSE_SINB", &sinb);
		geti("ROSE_SINA", &sina);
		geti("ROSE_RMAX", &rmax);
		geti("ROSE_VALQ", &valq);
		geti("ROSE_ROUND", &rnd);
		int n = 1 << sinb;
		for (int i = 0; i < n; i++) {
			double v = sin(2.0 * 3.14159265358979323846 * i / n) * (double)(1 << sina);
			sintab[i] = (int)lround(v);
			int lim = 1 << sina;
			if (sintab[i] > lim) sintab[i] = lim;
			if (sintab[i] < -lim) sintab[i] = -lim;
		}
		rnd_on = rnd;
		n_pos = ovf_pos = n_val = ovf_val = n_mul = ovf_mul = n_draw = clamp_r = 0;
	}

	void geti(const char *name, int *out) {
		const char *e = getenv(name);
		if (e && *e) *out = atoi(e);
	}

	// Reduce a 16.16 number to `frac` fractional bits: truncate toward -inf,
	// or round to nearest when ROSE_ROUND=1 (costs one add on the 6502 and
	// turns a systematic per-step bias into a zero-mean random walk).
	static int rnd_on;
	static inline int q(int v, int frac) {
		int sh = 16 - frac;
		if (sh <= 0) return v;
		if (rnd_on) v += 1 << (sh - 1);
		return (v >> sh) << sh;
	}

	inline int sinlut(int idx) const { return sintab[idx & ((1 << sinb) - 1)]; }

	// Quarter turn ahead = cosine.
	inline int coslut(int idx) const { return sinlut(idx + (1 << (sinb - 2))); }

	inline int qpos(int v) {
		n_pos++;
		if (v >= (512 << 16) || v < -(512 << 16)) ovf_pos++;
		return q(v, posq);
	}

	inline int qdir(int v) {
		return q(v, dirq) & 0x00FFFFFF;   // 16-bit 8.8 register: wraps every 256 units
	}

	inline int qval(int v) {
		if (!valq) return v;
		n_val++;
		if (v >= (512 << 16) || v < -(512 << 16)) ovf_val++;
		return q(v, valq);
	}

	// 16-bit multiply in the VALQ format: (a*b) >> valq, tracking 16-bit overflow.
	inline int mulval(int a, int b) {
		int sh = 16 - valq;
		long long aq = a >> sh, bq = b >> sh;
		long long r = (aq * bq) >> valq;
		n_mul++;
		if (r > 32767 || r < -32768) ovf_mul++;
		return (int)(r << sh);
	}

	inline int divval(int a, int b) {
		int sh = 16 - valq;
		long long aq = a >> sh, bq = b >> sh;
		if (bq == 0) return 0;
		long long r = (aq << valq) / bq;
		n_mul++;
		if (r > 32767 || r < -32768) ovf_mul++;
		return (int)(r << sh);
	}

	inline int qradius(int r) {
		n_draw++;
		if (rmax && r > rmax) { clamp_r++; return rmax; }
		return r;
	}

	void report(FILE *f) const {
		if (!on) return;
		fprintf(f, "MICRO posq=%d dirq=%d sinb=%d sina=%d rmax=%d valq=%d\n",
			posq, dirq, sinb, sina, rmax, valq);
		fprintf(f, "MICRO_POS_OVERFLOW %lld / %lld\n", ovf_pos, n_pos);
		fprintf(f, "MICRO_RADIUS_CLAMPED %lld / %lld\n", clamp_r, n_draw);
		if (valq) {
			fprintf(f, "MICRO_VAL_OVERFLOW %lld / %lld\n", ovf_val, n_val);
			fprintf(f, "MICRO_MUL_OVERFLOW %lld / %lld\n", ovf_mul, n_mul);
		}
	}
};

extern MicroConfig micro;
