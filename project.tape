@V := "tape" :: spec [active]
  version = "1.2"

@I := "hexa-codex" :: identity [active]
  kind     = "AI knowledge substrate (17-verb spec library · `lm_foundry/` hexa-lang code-LLM 94.29% Mk.I)"
  brief    = "Safety · economics · ops · substrate verbs + 3-vendor orchestration runtime."
  parent   = "dancinlab"
  ssot     = "github.com/dancinlab/hexa-codex (`hx install hexa-codex`)"
  siblings = "hexa-lang"

@D cx_hf_complete := "HF registration — complete, no missing artifacts" :: governance [required active]
  do   = "register every model / dataset / ckpt to HF Hub COMPLETE — all artifacts present · manifest = local"
  dont = "partial HF upload · model card referencing un-uploaded files · HF repo out of sync with local"

@D cx_claim_manifest := "CLAIMS.tape — single index of verifiable claims" :: workflow [required active]
  do   = "every verifiable claim listed in root CLAIMS.tape — id · text · method (atom|expr|fence|run)"
  dont = "scatter claims across docs without a CLAIMS.tape index — paper has no audit surface"

@D cx_claim_verify := "every claim runs through hexa verify, verdict persisted" :: workflow [required active]
  do   = "each CLAIMS.tape entry → `hexa verify` → `.verdicts/<slug>.tape` w/ raw stdout verbatim"
  dont = "LLM self-judge correctness · paraphrase verdicts · hide red / unfenced speculation"

@D cx_empirical_contact := "T4 claims execute real train/infer/serve benchmark" :: workflow [required active]
  do   = "T4 claims run lm_foundry train · hexa-eval infer · serving bench — metrics in .verdicts"
  dont = "fence empirical claim · accept simulator-only output · skip T4 bench when claim is empirical"

@D cx_paper_gate := "/paper gated on 100% verified-by-recompute AND significance" :: workflow [required active]
  do   = "`/paper new <slug>` only when 100% formal(blue) or numerical(green) AND significance satisfied"
  dont = "scaffold w/ any fenced/deferred/falsified/citation-only · trivial atom recheck · bookkeeping"

@D cx_paper_significance := "paper requires formula + benchmark + measured benefit" :: workflow [required active]
  do   = "paper triggers only on formula + real bench + quantified benefit (cost/latency/accuracy delta)"
  dont = "paper for atlas atom recheck · known identity · bookkeeping closure · unverified prediction"

@D cx_paper_format := "paper sections — formula · method · benchmark · benefit" :: workflow [required active]
  do   = "paper §formula · §method · §benchmark (real run) · §benefit (delta vs baseline)"
  dont = "narrative-only · benchmark substitute for formula · skip §benefit · vague qualitative claims"

@D cx_paper_sections := "every paper section claim links to its verdict" :: workflow [required active]
  do   = "every paper section claim links to its .verdicts/<slug>/<id>.txt formal-blue verdict"
  dont = "ship paper with any unresolved residual section · treat verdict matrix as optional"

@D cx_paper_violation := "violating paper immediately revoked" :: workflow [required active]
  do   = "violating paper (cx_paper_gate / significance fail) revoked immediately — PAPER/<slug>/ removed"
  dont = "keep violating paper as draft · mark WIP · defer revocation · allow gate-failure residual"

@D cx_paper_one_per_domain := "one canonical paper per group — ECONOMICS · SAFETY · OPS · SUBSTRATE" :: workflow [required active]
  do   = "ship one canonical paper per domain group — replace in place when a stronger finding lands"
  dont = "ship multiple papers per group · accumulate paper backlog · fork same-group narratives"

@D cx_discovery := "discovery runs continuously, not only at cycle tail" :: workflow [required active]
  do   = "interleave `/kick` / `/gap` discovery every batch — a discovery lane runs alongside verify"
  dont = "defer discovery to the end · single tail-only round · stop discovering once a paper ships"

@D cx_discovery_log := "discoveries persist at .discoveries/<slug>.tape" :: workflow [required active]
  do   = "log every kick/gap discovery to `.discoveries/<slug>.tape` — id · seed · verdict-tier-target"
  dont = "discard discovery output · paraphrase findings · skip linking discovery → next-cycle claim"
