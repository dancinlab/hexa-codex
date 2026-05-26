@V := "tape" :: spec [active]
  version = "1.2"

@I := "discoveries-log" :: identity [active]
  slug   = "sandbox-n1-cross-substrate-reproducibility"
  source = "SANDBOX NOVEL 축 N1 spawned from cycle-23c (16-item, 4-rung) vs cycle-24 (50-item, 3-rung partial) cross-manifest contradiction (cycle-28, MAIN PRIORITY)"
  date   = "2026-05-27"
  flow   = "cycle-23c-V-shape -> cycle-24-monotone-partial -> novel meta-measurement axis N1 seed (cx_discovery_log)"

# ════════════════════════════════════════════════════════════════════
# CONTEXT — why N1 spawns from cycle-23c × cycle-24 contradiction
# ════════════════════════════════════════════════════════════════════
# cycle-23c (`.verdicts/sandbox/m5_substrate_multimodal_fit_4rung.txt`,
# 16-item harder manifest, 4 VL rungs, n=5 per counting bucket):
#
#   COUNTING axis (5-9 dense objects, n=5):
#     0.5B SmolVLM-500M     : 4/5 = 80%
#     2.2B SmolVLM2         : 4/5 = 80%
#     3.0B Qwen-VL-3B       : 2/5 = 40%   ← dip
#     7.0B Qwen-VL-7B       : 5/5 = 100%  ← recovery
#   Shape: NON-MONOTONE V (dip-then-recover) — quadratic-in-log2(params) RMSE
#   strictly beats monotone-logistic by ΔRMSE 0.00229607.
#
# cycle-24 (`.verdicts/sandbox/p1_subitizing_50item.tsv`,
# 50-item dense-object refinement, 3 VL rungs only [7B stuck], n=50):
#
#   COUNTING axis (5-9 dense objects, n=50 [3.0B partial n=24]):
#     0.5B SmolVLM-500M     :  6/50 = 12%
#     2.2B SmolVLM2         : 28/50 = 56%
#     3.0B Qwen-VL-3B       : 18/24 = 75% (partial)
#     7.0B Qwen-VL-7B       : (stuck, no data)
#   Shape: MONOTONE-INCREASING (12% → 56% → 75% partial)
#
# CONTRADICTION. Same SANDBOX substrate, same VL rungs (modulo n & dense-vs-
# sparse PIL generator), same byte-exact scorer family — yet the *shape* of
# the counting-axis ladder is OPPOSITE. The 3-rung subset where data overlaps:
#
#   rung  | cycle-23c (n=5)  | cycle-24 (n=50, partial)
#   0.5B  | 80%              | 12%
#   2.2B  | 80%              | 56%
#   3.0B  | 40%              | 75%
#
# Possible reasons:
#   (R1) cycle-23c counting (n=5) is too small — V-shape is a small-sample
#        artifact, cycle-24 partial reflects the true monotone ladder
#   (R2) 50-item PIL generator difficulty distribution differs from 16-item
#        (denser objects? smaller render? manifest comparability broken)
#   (R3) Qwen-VL-3B subitizing dip is real but only at sparse counts
#        (16-item count_7=7 / count_8=8 = sparser layouts dip; 50-item dense
#        regimes don't trigger the same failure mode)
#   (R4) BOTH findings reflect different but real substrate behaviour at
#        different scales — neither is "wrong", both must be reported.
#
# Whichever holds, the meta-axis is: SANDBOX measurements MUST be checked
# for reproducibility across (manifest n, rendering recipe, model family,
# quant) at the SAME tier before downstream papers / claims cite them.

@C d_sandbox_n1_cross_manifest_rank_correlation := "cycle-23c 16-item vs cycle-24 50-item counting axis 가 공통 3-rung 부분집합에서 일치하는가" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "harness verify/numerics_sandbox_n1_reproducibility.hexa — committed .verdicts/sandbox/{m5_substrate_multimodal_ladder.tsv, p1_subitizing_50item.tsv} 두 TSV 의 counting axis 만 추출 · 공통 3-rung 부분집합 (0.5B/2.2B/3B) 에서 per-rung accuracy delta + Spearman rank-correlation + sign-agreement of adjacent-pair deltas (sgn(acc[i+1]-acc[i])). 닫힌형 recompute (외부 fire 없음, $0). emit verdict tier — 🟢 if Spearman ≥ 0.5 AND sign-agreement ≥ 1/2, 🟠 if n=3 too small for confident statistics."
  hyp     = "공통 3-rung 부분집합에서 rank-correlation < 0.5 AND sign-agreement 0/2 → manifest-scale 이 finding 모양을 결정 → cycle-23c V-shape 가 small-N artifact 확정 · cycle-24 monotone 이 ground truth"
  verdict = "PENDING — cheapest first probe (no substrate fire, no model load, no GPU). 외부 anchor: subitizing capacity ≤4 (Kaufman et al 1949 · Trick & Pylyshyn 1994) 가 5-9 dense-object regime 에서는 자체적으로 어려운 task 라는 prior 제공 — n=5 와 n=50 모두 subitizing limit 위에서 측정중이므로 absolute accuracy 는 manifest-density-dependent 가 자연스러움 · shape (rank-order) 만 비교 의미있음."

@C d_sandbox_n1_manifest_difficulty_comparability := "50-item PIL generator difficulty 분포 가 16-item 과 동일한가 (manifest comparability)" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "harness bench/sandbox_n1_manifest_comparability_probe.hexa (cycle-29+) — 16-item 과 50-item PIL generator 의 (object-count, render-density, image-size, color-palette) feature 분포 비교 · 닫힌형 KS-test 가능 (각 axis 별 cdf 비교). 또는 5-rung VL 의 inter-manifest rank-correlation (각 rung × 두 manifest = 2 cell) 비교 — 같은 rung 에서 두 manifest 의 accuracy 차이 가 5pp 이내 면 manifest-comparable."
  hyp     = "두 manifest 의 generator parameter (object-count distribution + render-density) 가 동일하지 않으면 cross-cycle finding 비교는 cf cycle-29 의 controlled 재실행 (smaller subset + same seed + same generator) 까지 deferred — N1 seed 1 의 honest residual."
  verdict = "PENDING — bench harness 작성 필요 (cycle-29+ 의 cheapest next probe). cycle-25 의 50-item 재실행 (TIME-CAPPED) 가 1st step — 같은 generator 재실행이 manifest comparability 직접 측정."

@C d_sandbox_n1_meta_measurement_lane := "SANDBOX measurement reproducibility 가 영구 hygiene lane 으로 자리잡는가" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "harness inbox/notes/n1-meta-measurement-checklist.md (cycle-28+) — 모든 substrate-measured finding 에 'reproducibility check across (manifest n × model family × quant)' 가 mandatory checklist row 로 등록. 영구 hygiene rule: 새 SANDBOX finding 이 paper / verdict 로 ship 되기 전 반드시 cross-substrate replication 1 probe 통과 (또는 honest residual 명시)."
  hyp     = "N1 axis 가 영구 enforcement lane (cx_discovery 와 같은 SSOT rule) 로 자리잡으면 cycle-23c × cycle-24 형식의 cross-cycle contradiction 이 사후 발견되는 일 없어짐 — pre-flight check 로 잡힘."
  verdict = "PENDING — checklist + governance entry (cycle-28+ 후속). 1차로 N1 verifier 가 cross-cycle reproducibility 의 첫 closed-form template — 다른 SANDBOX 측정에 generalise 할 reference impl."

# ════════════════════════════════════════════════════════════════════
# CROSS-CYCLE LINKAGE
# ════════════════════════════════════════════════════════════════════
# - cycle-23c: 4-rung 16-item harder manifest V-shape counting finding
#   (`.verdicts/sandbox/m5_substrate_multimodal_fit_4rung.txt` 🟢)
# - cycle-24: 50-item dense subitizing partial monotone counting finding
#   (`.verdicts/sandbox/p1_subitizing_50item.tsv` 🟠 INSUFFICIENT, 7B stuck)
# - cycle-28 N1 first-probe: closed-form rank-correlation recompute on
#   committed 3-rung subset (no new fire) — directional verdict
# - cycle-29+ N1 follow-ups: bench harness for manifest-difficulty
#   comparability + meta-measurement hygiene checklist registration
# - Mirror parent: ECONOMICS cycle-27 axis E1 (NOVEL) cross-cycle finding
#   spawn pattern (`.discoveries/economics-e1-moe-dense-divergence.tape`)
#
# Honest residual:
# - n=3 공통 rung 은 Spearman 계산에는 가능하지만 confidence interval 좁히기에는
#   너무 작음. 🟠 INSUFFICIENT 가능성 명시. cycle-25 50-item 재실행 (5-rung 완주)
#   가 진정한 close 경로 — N1 first-probe 는 directional evidence 만 제공.
# - cycle-23c counting n=5 per bucket × 5 buckets = 25 trials per rung 이지만
#   bucket-level (count_5/6/7/8/9) accuracy 는 n=1 binary — V-shape 의 통계적
#   load-bearing 정도는 quadratic vs logistic RMSE Δ=0.00229607 (전체 16-pt)
#   만큼만 강함.
# - cycle-24 partial 3.0B 는 24/50 trials only (7B stuck 으로 wall-time 부족) —
#   75% accuracy 는 SE ≈ √(0.75·0.25/24) ≈ 8.8pp · 50/50 fill 시 점 이동 가능.
# - manifest difficulty comparability (R2 hypothesis) 가 분리되지 않으면
#   contradiction 의 원인 (small-N artifact vs manifest-shape artifact) 도 분리
#   불가 — seed 2 가 그 확인 lane.
