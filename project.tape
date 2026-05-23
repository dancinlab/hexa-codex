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

@D cx_paper_gate := "/paper scaffolding gated on verdict closure" :: workflow [required active]
  do   = "`/paper new <slug>` only after verdict closed — see cx_paper_sections for tier split"
  dont = "scaffold before verdict closure · ship paper with unverified headline claims"

@D cx_paper_sections := "paper sections mirror verdict tiers" :: workflow [required active]
  do   = "paper sections split by tier — §verified (atom/numeric) · §pending · §fenced"
  dont = "merge tiers into one section · paraphrase verify CLI verdicts in paper prose"
