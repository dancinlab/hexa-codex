@V := "tape" :: spec [active]
  version = "1.2"

@I := "discoveries-log" :: identity [active]
  slug   = "sandbox-p2-prod-sae"
  source = "SANDBOX perpetual axis P2 — production-scale SAE re-openability conditions for the M5.SAFETY closed-negative (cycle-21)"
  date   = "2026-05-26"
  flow   = "first-arc-closed -> M5.SAFETY SAE-half 🔴 honest-negative (scale-bounded) -> P2 reopens at larger corpus+compute+dictionary tier -> re-open trigger spec (cx_discovery_log)"

# ════════════════════════════════════════════════════════════════════
# CONTEXT — what closed and what would reopen the SAE half
# ════════════════════════════════════════════════════════════════════
# SANDBOX.md M5.SAFETY residual (2)b CLOSED 🔴 honest-negative (cycle-20):
# the L19 refusal direction `r` does NOT decompose into a small set of
# monosemantic SAE features at this model/data/compute scale.
#
# Measured at-scale numbers (verdict .verdicts/sandbox/m5_safety_sae_decomposition.txt):
#   corpus:       1,550 NEUTRAL prompts × ~39 tokens = 59,795 token-acts × 1536-dim
#   SAE:          ReLU L1, width 6144 (=4× residual), L1=0.4 warmup, 40 epochs
#   sparsity:     mean L0=3.6, 278 alive of 6144 (5866 dead), FVU=0.0005
#   alignment:    max |cos(decoder feature, r̂)| = 0.085
#   top-10 cap:   4.8% of r̂ energy
#   ablation:    top-10 SAE features removed → refusal 0.90 vs random-10 0.8833 (no
#                meaningful drop vs full-dense `r` collapse 0.95→0.00, PR #60)
#   PCA control: best PC |cos|=0.125, top-20 captures 6.7% of r̂
#   invariance:  3 sparsity regimes (L0≈8626 / 1.7 / 3.6) all max|cos|≈0.08–0.10
#                — NOT an L1-tuning artifact
#
# Diagnosis: refusal mediator is DENSE/distributed in L19, near-orthogonal to
# every learned dictionary atom under the achievable scale. NOT universal —
# scale-bounded (the ~10 tokens/feature ratio is far below production SAE
# scale, hence 5866/6144 dead features). The negative is REOPENABLE under
# a larger-scale tier.
#
# Selection rule (g0 Occam + cx_lab_falsifiable): each REOPEN candidate must
# (a) state a CRISP measurable threshold the M5 cycle-20 run did NOT meet,
# (b) link the threshold to an INVARIANT-VS-LEVER axis (corpus size /
# dictionary width / SAE family / layer / compute tier), and (c) be CHEAP
# enough to scope today even though the run itself is expensive.
#
# Four reopen-trigger seeds below — corpus×width primary, SAE-family alt,
# multi-layer fallback, compute-tier path.

@C d_p2_corpus_dictionary_scaleup := "Anthropic-tier corpus × wider dictionary — the canonical reopen condition" :: seed [verified_tier_target=YELLOW status=open]
  cmd     = "harness bench/sandbox_p2_prod_sae.hexa — rerun the L19 refusal-direction decomposition with (a) corpus ≥ 5M token-acts (≥83× the cycle-20 60k baseline; matches Bricken-et-al/Cunningham-2023 minimum SAE training regime), (b) dictionary width ≥ 16384 (=2.67× width vs cycle-20's 6144, ≥3 tokens/feature ratio target ≥305), (c) SAME L19 capture protocol (HF transformers+hooks on Qwen2.5-1.5B-Instruct fp32, same NEUTRAL corpus family — extend with The-Pile / RedPajama / FineWeb-Edu sample), (d) SAME measurement bar: report max|cos(decoder, r̂)|, top-K energy capture, top-K ablation Δ vs random-K control; recompute by verify/numerics_safety_sae_alignment.hexa"
  hyp     = "at ≥305 tokens/feature scale, ≥30 features alignment-meaningful (cos≥0.3) AND top-10 captures ≥40% of r̂ energy AND top-10 ablation drops refusal by ≥0.3 (i.e. the SAE recovers a small monosemantic refusal-feature cluster, reopening the cycle-20 honest-negative)"
  verdict = "PENDING — primary reopen path. Compute cost: ~5M token-acts × 1536 dims × fp32 ≈ 30 GB raw activations alone (cycle-20 was ~0.37 GB), training a wider SAE on A100 80GB ≈ 4-8 hours. Plausible on RunPod A100 80GB / vast.ai 80GB ($0.5-$2 budget). Falsifier (a STRONGER closed-negative): if at this scale max|cos| stays <0.15 AND top-10 energy <10%, the dense-distributed claim hardens — refusal is NOT recoverable as a small monosemantic set on Qwen2.5-1.5B at any practical SAE scale. Falsifier (a REOPEN): if max|cos|≥0.3 emerges, the cycle-20 negative was scale-bounded and the M5.SAFETY half flips to a positive interventional motif."

@C d_p2_top_k_sae_family := "Top-K / JumpReLU / BatchTopK SAE family — different sparsity prior, same axis" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "harness bench/sandbox_p2_topk_sae.hexa — at the cycle-20 corpus scale (60k token-acts) OR the d_p2_corpus_dictionary_scaleup corpus, replace the ReLU L1 SAE with (a) Top-K (Gao-Goh-Heimersheim 2024, K∈{8,16,32}), (b) JumpReLU (Rajamanoharan 2024, threshold-and-zero), (c) BatchTopK (Bussmann 2024, batch-level K constraint); all three eliminate the L1 underconsumption pathology that may have caused the cycle-20 max|cos|=0.085 plateau; measurement bar identical"
  hyp     = "EITHER (i) max|cos(decoder, r̂)| jumps to ≥0.25 on Top-K/JumpReLU even at the cycle-20 60k corpus scale (the L1 prior was the load-bearing cause of the negative, NOT corpus size), OR (ii) all three families plateau at the same ≤0.10 (corpus size IS the load-bearing cause, not the sparsity prior — cleanly isolates the lever)"
  verdict = "PENDING — cheap LEVER-isolation probe. Distinguishes which of (sparsity prior vs corpus size) caused the cycle-20 negative. Same compute cost as cycle-20 if corpus held constant (60k token-acts → fits ubu-1 RTX 5070 12GB, the original $0 lane). Should run BEFORE d_p2_corpus_dictionary_scaleup to inform the larger-scale design — if Top-K already lifts max|cos| at 60k, the larger-scale run uses Top-K not L1."

@C d_p2_multilayer_residual_attribution := "multi-layer attribution — does the refusal direction decompose better at L17 or L18 source layers (cycle-19 ablation runner-ups)?" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "harness bench/sandbox_p2_multilayer_sae.hexa — at the cycle-20 corpus scale (60k token-acts) capture residuals at L17 + L18 + L19 + L20 + L21 (cycle-19 ablation showed L19 load-bearing with 0.95→0.00 but L17/L18 also drop refusal 0.65/0.60); train one SAE per layer (same ReLU L1 + width 6144 as cycle-20), recompute max|cos(decoder, layer-r̂)| per layer where layer-r̂ is the per-layer difference-of-means refusal direction; identify whether SAE alignment correlates with ablation strength OR with layer depth (cycle-20 was a single-layer probe)"
  hyp     = "max|cos| varies non-trivially across layers (≥0.05 spread); the BEST-alignment layer ≥ the cycle-20 L19 number (0.085) — i.e. layer choice matters. WEAKER alternate: alignment correlates with the M2.SAFETY motif AUROC ranking (L19>L18>L17), so L19 was already the best single layer"
  verdict = "PENDING — robustness probe at no extra corpus cost (only multiplies the per-layer SAE training, ≤5× cycle-20 GPU-hours on ubu-1 RTX 5070). If the BEST layer's max|cos| stays ≤0.10, the dense-distributed claim generalises across the residual stream, hardening the negative. If a different layer (e.g. L17, where MLP write is also strong per cycle-16 motif (1)) shows max|cos|≥0.20, the cycle-20 closure was layer-myopic — reopens at that layer."

@C d_p2_runpod_compute_tier_runbook := "concrete RunPod/vast.ai dispatch runbook for d_p2_corpus_dictionary_scaleup (NOT a probe, an infrastructure seed)" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "scope-only — produce a runbook in `inbox/notes/p2-prod-sae-pod-runbook.md` covering (a) chosen platform (vast.ai A100 80GB $0.48-$1.07/hr per [[reference_vastai_cli]] vs RunPod given [[project_runpod_platform_incident]]), (b) corpus selection (The-Pile-subset / FineWeb-Edu / Cosmopedia ≥5M token-acts, license-clean), (c) dispatch via /cloud preflight + nohup + tail, (d) activation cache strategy (sequential capture with disk spill to avoid 30GB RAM blow-up — chunked HDF5 or memmap), (e) SAE training loop (use Anthropic's open-source `sparse_autoencoder` repo OR Bricken-et-al's reference; pin to a public commit), (f) verifier-friendly TSV emit at exit (same `numerics_safety_sae_alignment.hexa` schema)"
  hyp     = "the runbook is COMPLETE in the sense that a follow-up cycle can fire the experiment with zero new infra decisions"
  verdict = "PENDING — infrastructure-prep seed. ZERO compute cost (writing the runbook), defers the expensive experiment until the cheaper d_p2_top_k_sae_family probe lands its lever-isolation result. Per cycle-15 LEARNING [[reference_vastai_cli]], vast.ai A100 80GB at $0.48/hr makes the whole d_p2_corpus_dictionary_scaleup run plausibly $2-$10 if 4-8 hrs."
