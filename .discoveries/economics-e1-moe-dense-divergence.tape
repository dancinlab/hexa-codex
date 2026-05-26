@V := "tape" :: spec [active]
  version = "1.2"

@I := "discoveries-log" :: identity [active]
  slug   = "economics-e1-moe-dense-divergence"
  source = "ECONOMICS NOVEL 축 E1 spawned from cycle-26 C1 cross-cycle finding (cycle-27)"
  date   = "2026-05-27"
  flow   = "cycle-26-C1-finding -> 12/12 dense overtrain + 1/1 MoE active-Chinchilla-exact -> novel axis E1 seed (cx_discovery_log)"

# ════════════════════════════════════════════════════════════════════
# CONTEXT — why E1 spawns from C1
# ════════════════════════════════════════════════════════════════════
# cycle-26 C1 (`.verdicts/economics/c1_chinchilla_envelope.tsv`, 13 landings)
# measured per-model D/N ratio vs Hoffmann 2022 Chinchilla rule (D/N≈20):
#
#   12 dense landings: Llama3 8B/70B/405B · Qwen2.5-72B · Phi-3 mini/small/medium
#                      · Gemma-2 2B/9B/27B · Chinchilla-70B anchor
#     ALL OVERTRAIN: D/N ∈ [22.1, 1875], median ≈ 250 (12.5× Chinchilla)
#
#   1 MoE landing: DeepSeek-V3 671B total / 37B active / 14.8T tokens
#     active D/N = 20.000 EXACT (Chinchilla rule-of-thumb 정확 hit)
#     total  D/N = 22.1  (≈ dense median 의 1/11)
#
# Reading: MoE active-param 가 dense scaling law 와 distinct family 일
# 가능성. n=1 sample 은 anecdote 이므로 ≥3 MoE landing 으로 확인 필요.
# 대안 reading: DeepSeek-V3 가 단순 outlier (Mixtral/Qwen3-MoE 가 dense
# 분포 안에 들어가면 divergence FALSIFIED, single coincidence 로 결론).
#
# 본 seed 는 perpetual axis E1 의 첫 candidate batch — actual collection +
# verifier 는 cycle-28+ 후속에서 fire (cheapest = WebFetch + closed-form
# KS-test recompute, no substrate run, $0).

@C d_econ_e1_moe_active_param_law := "MoE active-param scaling law 가 dense 와 distinct family 인가" :: seed [verified_tier_target=YELLOW status=open]
  cmd     = "harness verify/numerics_economics_e1_moe_dense_divergence.hexa — collect ≥3 MoE landings (DeepSeek-V3 [done · cycle-26] · Mixtral 8x7B · Qwen3-MoE 235B or similar) via WebFetch + per-landing (N_total, N_active, D, citation_url) into `.verdicts/economics/e1_moe_landings.tsv` · compute active_D_over_N per MoE row + KS 2-sample test vs cycle-26 12-row dense D/N distribution · emit per-axis verdict tier (🟢 if KS p<0.05 distinct, 🔴 if p≥0.05 same distribution)"
  hyp     = "≥3 MoE landings 의 active-D/N 가 dense distribution 과 KS p<0.05 distinct — MoE follows distinct scaling law family (likely closer to Chinchilla on active-param)"
  verdict = "PENDING — cheapest first probe (WebFetch + closed-form KS recompute, no substrate run, $0). 외부 anchor: DeepSeek-V3 arXiv:2412.19437 (cycle-26 fetched), Mixtral 8x7B arXiv:2401.04088, Qwen3-MoE technical report (HF model card). Sardana 2024 arXiv:2401.00448 의 inference-amortization framework 가 MoE 의 train-time decision 을 다르게 설명할 수 있는지 — 보조 axis."

@C d_econ_e1_moe_inference_cost_per_token := "MoE active-param 만 active 이므로 inference $/tok 가 active scaling 만 따르는가" :: seed [verified_tier_target=YELLOW status=open]
  cmd     = "harness verify/numerics_economics_e1_moe_inference_cost.hexa — DeepSeek-V3 active 37B · Mixtral 8x7B active 12.9B · vs dense Llama3-70B (active=total=70B) (N_active, measured token/s on substrate or published) → $/tok per active-param fit · compare slope vs dense slope. 반증자: MoE $/tok 가 active-param scaling 만 따르고 total 안 따름 → routing cost가 negligible · 반증 case: total scaling 도 따름 → routing overhead 가 active advantage 상쇄"
  hyp     = "MoE inference $/tok 가 active-param 의 dense scaling 과 동일 (routing overhead negligible 가설)"
  verdict = "PENDING — substrate fire 필요 (DeepSeek-V3 model 무겁고 자원 부족 → 외부 published latency 수치 + Mixtral 8x7B (Q4_K_M ~13GB, mac M3 24GB UMA 가능) 가 cheapest 시작점). 후속 cycle 작업."

@C d_econ_e1_moe_sardana_envelope := "MoE 의 inference-amortization 가 active-only 적용시 dense Sardana 와 같은 envelope 인가" :: seed [verified_tier_target=YELLOW status=open]
  cmd     = "harness verify/numerics_economics_e1_moe_sardana.hexa — Sardana 2024 (arXiv:2401.00448) inference-aware total-cost N* 식의 N 을 'active' 로 대체할 때 envelope shape 가 same form 인가. closed-form recompute (no substrate). 12 dense + ≥3 MoE landings 의 (T_inf, N_optimal_sardana) curve 비교."
  hyp     = "Sardana envelope 는 N=N_active 로 대체하면 MoE 도 same family (즉, MoE 의 over-overtraining 이 dense 와 같은 inference-amortization 신호로 설명 가능)"
  verdict = "PENDING — closed-form recompute only ($0). D1 seed 5 (d_econ_d1_inference_amortization_envelope) 와 자연 후속 — E1 가 active-substituted variant. cycle-28 cheapest probe 후보 (D1 seed 5 + E1 seed 3 함께 묶음 가능)."

# ════════════════════════════════════════════════════════════════════
# CROSS-CYCLE LINKAGE
# ════════════════════════════════════════════════════════════════════
# - cycle-26 C1 finding: DeepSeek-V3 active D/N=20 exact (n=1, anecdote)
# - cycle-26 D1 seed 5 (d_econ_d1_inference_amortization_envelope): Sardana 2024
#   envelope test (dense only)
# - E1 = "MoE 분리 가능성 측정" + "Sardana envelope active-variant" 두 lane 융합
# - E1 first probe (cheapest): seed 1 (MoE landings collection + KS test, $0)
# - E1 후속: seed 3 (Sardana active-variant recompute) — closed-form, $0
#
# Honest residual:
# - n=1 (DeepSeek-V3) 가 발견의 출처이므로 confirmation bias 위험 명시.
#   ≥3 MoE landings 가 들어와야 statistical 의미.
# - MoE 의 N_active 정의는 paper 마다 다름 (per-token activated experts ×
#   per-expert params) — landings collection 시 정의 일치 필요.
