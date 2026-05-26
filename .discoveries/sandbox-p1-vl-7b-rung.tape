@V := "tape" :: spec [active]
  version = "1.2"

@I := "discoveries-log" :: identity [active]
  slug   = "sandbox-p1-vl-7b-rung"
  source = "SANDBOX perpetual axis P1 — higher scale rungs (multimodal 4th rung first, scale-cost rung second) (cycle-21)"
  date   = "2026-05-26"
  flow   = "first-arc-closed -> M5.SUBSTRATE multimodal-half closed-by-honest-negative -> P1 reopens at scale (next rung up) (cx_discovery_log)"

# ════════════════════════════════════════════════════════════════════
# CONTEXT — what P1 is and which rung to land first
# ════════════════════════════════════════════════════════════════════
# SANDBOX.md §영구 축 P1 = "higher scale rungs: 7B+ VL rung (SUBSTRATE 축 A)
# + 더 큰 text 모델 — perception saturation/counting 회복 + scale-cost
# rung (ECONOMICS 축 A) 동시 공급". The cycle-20 multimodal ladder closed
# the M5.SUBSTRATE multimodal half as a NON-MONOTONE honest-negative:
#   0.5B 81.25% → 2.2B 93.75% → 3.0B 81.25%  (overall)
#   perception axis (ocr+spatial+shape): 9/11 → 11/11 → 11/11 (saturating)
#   counting axis (5–9 dense objects): does NOT track params (subitizing limit)
# .verdicts/sandbox/m5_substrate_multimodal_fit.txt (🟢 honest-negative).
#
# P1 first cell asks the natural next-tier question: at 7B+ does the
# COUNTING axis recover, or does perception saturation hold while counting
# stays flat (architectural subitizing limit)? This is the LOAD-BEARING
# falsifier of the cycle-20 finding.
#
# Selection (g0 Occam): one rung at the smallest 7B+ VL model that has a
# WORKING mmproj on llama-mtmd-cli + fits the M3 mac 24GB UMA at Q4_K_M.
# Three candidates evaluated below + cheaper text-side scale-cost probe.

@C d_p1_vl_4th_rung_qwen_vl_7b := "4th VL rung — Qwen2.5-VL-7B-Instruct-Q4_K_M (same family as the cycle-20 3B rung, primary candidate)" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "harness bench/sandbox_p1_multimodal_ladder_7b.hexa = extend cycle-20 bench/sandbox_multimodal_ladder.hexa with a 4th rung at Qwen2.5-VL-7B-Instruct-Q4_K_M (~4.5GB weights + ~1.4GB mmproj ≈ 6GB on disk, runs on M3 24GB UMA with KV headroom for the 16-item bench); reuse the SAME 16-item PIL manifest (count×5 / ocr×4 / spatial×4 / shape×3) byte-exact-subset scorer (NO LLM self-judge), seed-pinned greedy (--temp 0 -s 42); recompute by verify/numerics_substrate_multimodal_fit.hexa with the 4-rung curve"
  hyp     = "(a) perception sub-ladder saturates flat at 11/11 (already at 2.2B), (b) counting axis EITHER recovers at 7B (subitizing limit was data-scale-bounded) OR stays at ≤3/5 (subitizing is architectural, holds even at 7B). Crisp 2-way falsifier — either reading is informative."
  verdict = "PENDING — single most-informative next multimodal measurement. Primary candidate because (1) same family as the 3B rung → architectural variable held constant, (2) ggml-org/Qwen2.5-VL-7B-Instruct-GGUF ships an mmproj that's known to load on llama-mtmd-cli 9150 (cycle-19/20 used the same family's 3B), (3) fits M3 UMA at Q4_K_M. Falsifier: if neither perception nor counting moves vs 2.2B/3B, the multimodal capability has plateaued under llama-mtmd-cli regardless of scale — substrate-stack ceiling finding."

@C d_p1_vl_4th_rung_intern_vl_8b := "alternate 4th VL rung — InternVL2.5-8B (different family, scale-vs-family separation)" :: seed [verified_tier_target=YELLOW status=open]
  cmd     = "as in d_p1_vl_4th_rung_qwen_vl_7b but with InternVL2.5-8B; ONLY if the primary Qwen-7B probe shows a NULL (no movement vs 2.2B/3B) — then a different family answers whether the ceiling is family-specific or stack-specific"
  hyp     = "if Qwen-VL-7B plateaus AND InternVL-8B unblocks counting at ≥4/5, the ceiling is Qwen-family-specific (training-data / tokenizer / ViT-LLM connector difference). If both plateau, the ceiling is llama-mtmd-cli stack-specific."
  verdict = "PENDING — contingency probe, fires only if d_p1_vl_4th_rung_qwen_vl_7b returns a NULL result. ggml-org has no first-party InternVL GGUF as of 2026-05; would need a community conversion. Lower-priority because it's two unknowns at once (family AND scale)."

@C d_p1_text_scale_cost_4b_rung := "scale-cost rung — Qwen2.5-4B text rung (M5.SUBSTRATE side-prediction + ECONOMICS scaling)" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "harness bench/sandbox_p1_text_4b_rung.hexa — land Qwen2.5-4B-Instruct-Q4_K_M (~2.5GB) on the substrate; re-run (a) the wc_31_60 Stage-2 nano persona eval (M3.SUBSTRATE manifest, N=150) AND (b) the F-CODEX-2 context-scaling bench (M3.ECON, 1k/2k/4k/8k rungs); recompute by (a) verify/numerics_substrate_cliff_logistic.hexa extended to 5 rungs to test cliff midpoint x0≈1.973, AND (b) verify/numerics_economics_empirical_landing.hexa to extend the measured τ̂ fit"
  hyp     = "(a) the 4B rung lands at y≈0.371 nano (the cycle-15c logistic prediction at x=log2(4)=2.0) within the N=30 binomial SE band of ±0.067 — i.e. measured nano(4B) ∈ [0.304, 0.438], (b) the τ̂≈0.524 context-cost exponent holds within ±0.05 when the fit is extended with the 4B latency curve"
  verdict = "PENDING — the single most-informative TEXT scale measurement (M4.SUBSTRATE §Limitations item 1: 'tighten the cliff bracket from [3B,7B] to a sharper interval'). $0 local (4B Q4_K_M GGUF fits 24GB UMA easily). Distinct from the VL 7B probe — text-side scaling, no multimodal stack. Falsifier: if measured nano(4B) lands outside [0.304, 0.438], the logistic family is wrong (real curve has a sharper or flatter cliff than the 2-param sigmoid)."

@C d_p1_test_set_scale_for_subitizing := "manifold scale-up for the counting axis — 50-item dense-object manifest to distinguish small-N noise from architectural ceiling" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "harness bench/sandbox_p1_subitizing_50item.hexa — extend the cycle-20 counting axis from 5 items (5–9 objects) to 50 items (5–9 objects × 10 samples per count = 50, stratified by object color/shape randomization with seed-pinned PIL generation); rerun against ALL 4 rungs from d_p1_vl_4th_rung_qwen_vl_7b + the cycle-20 ladder; tightens the per-rung counting accuracy std from binomial SE 0.20 (n=5) to 0.07 (n=50)"
  hyp     = "the cycle-20 counting NON-MONOTONE finding (rise-then-fall) holds at n=50 i.e. is not n=5 sampling noise — counting accuracy stays low (≤0.5) at ALL rungs"
  verdict = "PENDING — directly addresses cycle-20 honest-residual 'a 4th higher VL rung (7B+ with a loading mmproj) to test whether perception saturation holds + counting recovers at scale' AND tightens the statistical bar on the existing 3-rung counting evidence. $0 local (PIL generation deterministic). Should pair with d_p1_vl_4th_rung_qwen_vl_7b to harden the new rung result."
