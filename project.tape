@V := "tape" :: spec [active]
  version = "1.2"

@I := "hexa-codex" :: identity [active]
  kind   = "AI knowledge substrate (17-verb spec library · `lm_foundry/` hexa-lang code-LLM 94.29% Mk.I)"
  brief  = "Safety · economics · ops · substrate verbs + 3-vendor orchestration runtime."
  parent = "dancinlab"
  ssot   = "github.com/dancinlab/hexa-codex (`hx install hexa-codex`)"

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

@D cx_paper_gate := "/paper scaffolding gated on 100% formal-blue" :: workflow [required active]
  do   = "`/paper new <slug>` only when verdict 100% formal-blue — no other tier residual permitted"
  dont = "scaffold w/ any non-blue verdict · numerical/citation/fenced/deferred/falsified all blocked"

@D cx_paper_sections := "paper sections are all-verified" :: workflow [required active]
  do   = "every paper section claim links to its .verdicts/<slug>/<id>.txt formal-blue verdict"
  dont = "ship paper with any unresolved residual section · treat verdict matrix as optional"

@D cx_discovery := "each verify cycle pairs with a discovery round" :: workflow [required active]
  do   = "verify cycle paired with `/kick` or `/gap` round — new candidates feed next CLAIMS.tape"
  dont = "stop the cycle after verification · skip discovery · treat audit-only as the whole loop"

@D cx_discovery_log := "discoveries persist at .discoveries/<slug>.tape" :: workflow [required active]
  do   = "log every kick/gap discovery to `.discoveries/<slug>.tape` — id · seed · verdict-tier-target"
  dont = "discard discovery output · paraphrase findings · skip linking discovery → next-cycle claim"
