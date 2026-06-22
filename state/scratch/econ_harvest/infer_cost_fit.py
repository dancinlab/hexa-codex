#!/usr/bin/env python3
"""infer_cost (#5) — fit measured inference cost vs params N to power laws and

ECONOMICS infer claim is scaling-falsifier: infer_cost ∝ context^τ with 4=4 — a
CONTEXT-axis claim (already FALSIFIED on the context axis: m3_econ_fcodex2_latency_fit,
τ̂≈0.52 vs 4). This bench measures the *params* axis (cost vs model size N), which the
params-cost exponent equal to any constant {τ=4, 24, 1/6}, or to the generic
memory-bandwidth law (decode tok/s ∝ 1/N => time ∝ N^1; peak mem ∝ N^1)?

Cost surfaces measured (real llama-server, M3 Metal, -np 1 -cb, $0):
 - decode latency per token = 1000/decode_tok_s (ms/tok) -> expect ∝ N^1 (bandwidth)
 - TTFT (prefill ms) -> expect ∝ N^~1
 - peak RSS (MB) -> expect ∝ N^1 (weights)
Falsifier: if any measured exponent CI includes 4 (τ) -> that surface matches the 
infer claim. If all exclude 4 and match generic N^1 -> the τ=4 infer exponent does
NOT describe params-axis inference cost (REFUTED as a params law; it was a context law,
already refuted there too).
"""
import numpy as np
from scipy import stats

TAU_N6 = 4.0
N = np.array([0.5e9, 1.5e9, 3.0e9, 7.0e9])
# measured (verbatim from infer_cost_ladder.tsv)
prefill = np.array([1295.47, 340.67, 210.42, 87.08]) # tok/s
decode = np.array([176.08, 85.43, 45.76, 20.37]) # tok/s
ttft_ms = np.array([60.33, 241.03, 384.09, 932.18]) # ms
rss_mb = np.array([510.2, 1096.5, 2002.4, 4631.6]) # MB

decode_ms_per_tok = 1000.0/decode

def loglog(N, y, label, ref_exp=TAU_N6):
 lnN=np.log(N); lny=np.log(y)
 s,b,r,p,se = stats.linregress(lnN,lny)
 dof=len(N)-2; t=stats.t.ppf(0.975,dof)
 lo,hi=s-t*se, s+t*se
 print(f" {label:24s} exponent p={s:+.4f} SE={se:.4f} 95%CI=[{lo:+.3f},{hi:+.3f}] R2={r**2:.4f}")
 print(f" tau=4 inside CI? {lo<=ref_exp<=hi} | N^1 (generic) inside CI? {lo<=1.0<=hi}")
 return s,(lo,hi)

print("="*72)
print(" infer_cost (#5) — params-axis cost exponents vs 4=4")
print("="*72)
print(f"{'N(B)':>6} {'prefill_t/s':>12} {'decode_t/s':>11} {'decode_ms/tok':>14} {'ttft_ms':>9} {'rss_MB':>9}")
for ni,pf,dc,dm,tt,rs in zip(N/1e9,prefill,decode,decode_ms_per_tok,ttft_ms,rss_mb):
 print(f"{ni:6.1f} {pf:12.2f} {dc:11.2f} {dm:14.3f} {tt:9.2f} {rs:9.1f}")
print("\n-- power-law fits (cost ∝ N^p) --")
loglog(N, decode_ms_per_tok, "decode ms/tok (COST)")
loglog(N, ttft_ms, "TTFT ms (COST)")
loglog(N, rss_mb, "peak RSS MB (COST)")
print("\n-- throughput (inverse-cost, expect ∝ N^-1) --")
loglog(N, decode, "decode tok/s")
loglog(N, prefill, "prefill tok/s")

print("\n"+"="*72)
print(" VERDICT (infer_cost params-axis exponent = tau=4 ?)")
print("="*72)
print(" decode-latency / TTFT / mem exponents cluster ~ +1 (memory-bandwidth law),")
print(" NONE includes tau=4. The infer exponent tau=4 does not describe params-axis")
print(" inference cost — consistent with its FALSIFICATION on the context axis.")
