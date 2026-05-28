@V := "tape" :: spec [active]
  version = "1.2"

@I := "hexa-codex" :: identity [active]
  kind     = "AI knowledge substrate (17-verb spec library · `lm_foundry/` hexa-lang code-LLM 94.29% Mk.I)"
  brief    = "Safety · economics · ops · substrate verbs + 3-vendor orchestration runtime."
  parent   = "dancinlab"
  ssot     = "github.com/dancinlab/hexa-codex (`hx install hexa-codex`)"
  siblings = "hexa-lang · anima"

@D cx_hf_complete := "HF registration — complete, no missing artifacts" :: governance [required active]
  do   = "register every model / dataset / ckpt to HF Hub COMPLETE — all artifacts present · manifest = local"
  dont = "partial HF upload · model card referencing un-uploaded files · HF repo out of sync with local"

@D cx_hf_org := "canonical HF org + naming convention" :: governance [required active]
  do   = "under dancinlab/* — models `hexa-forge-*` · evals `hexa-codex-<domain>-evals-v<N>`"
  dont = "personal namespace · ad-hoc repo names · version-less ids"

@D cx_hf_eval_register := "every domain eval / bench input set registers as a HF dataset" :: governance [required active]
  do   = "domain eval/bench set → `hexa-codex-<domain>-evals-v<N>` · English card · verdict-linked"
  dont = "eval/bench set local-only · verdict whose input set is unregistered · missing card"

@D cx_hf_safety_private := "adversarial / harmful eval sets default PRIVATE" :: governance [required active]
  do   = "adversarial · refusal-matrix · jailbreak sets PRIVATE — public only on user sign-off"
  dont = "harmful prompts public w/o sign-off · adversarial mixed into a public set"

@D cx_hf_audit := "cx_hf_complete proven by a token-host HF↔local sync audit" :: governance [required active]
  do   = "completeness via authenticated audit on token host ubu-1 — incl. private · card↔file sync"
  dont = "assume sync from local manifest alone · self-judge completeness · audit token-less"

@D cx_claim_manifest := "CLAIMS.tape — single index of verifiable claims" :: workflow [required active]
  do   = "every verifiable claim listed in root CLAIMS.tape — id · text · method (atom|expr|fence|run)"
  dont = "scatter claims across docs without a CLAIMS.tape index — paper has no audit surface"

@D cx_claim_verify := "every claim runs through hexa verify, verdict persisted" :: workflow [required active]
  do   = "each CLAIMS.tape entry → `hexa verify` → `.verdicts/<slug>.tape` w/ raw stdout verbatim"
  dont = "LLM self-judge correctness · paraphrase verdicts · hide red / unfenced speculation"

@D cx_empirical_contact := "T4 claims execute real train/infer/serve benchmark" :: workflow [required active]
  do   = "T4 claims run lm_foundry train · hexa-eval infer · serving bench — metrics in .verdicts"
  dont = "fence empirical claim · accept simulator-only output · skip T4 bench when claim is empirical"

@D cx_paper_gate := "/paper gated on every section CLOSED-by-recompute AND significance" :: workflow [required active]
  do   = "`/paper new <slug>` only when every section CLOSED-by-recompute + significance"
  dont = "scaffold w/ any fenced/insufficient/citation-only · trivial atom recheck · bookkeeping"

@D cx_paper_significance := "paper requires formula + benchmark + (benefit OR closed refutation)" :: workflow [required active]
  do   = "paper triggers on formula + real bench + (quantified benefit OR closed-negative refutation)"
  dont = "paper for atom recheck · known identity · bookkeeping · unverified prediction · insufficient"

@D cx_paper_format := "paper sections — formula · method · benchmark · benefit|refutation" :: workflow [required active]
  do   = "paper §formula · §method · §benchmark (real run) · §benefit (delta) OR §refutation (gap)"
  dont = "narrative-only · benchmark substitute for formula · skip §benefit/§refutation · vague claims"

@D cx_paper_sections := "every paper section claim links to its verdict" :: workflow [required active]
  do   = "every section claim links to its .verdicts/<slug>/<id>.txt CLOSED-recompute verdict (+falsified)"
  dont = "ship paper with any unresolved residual section · treat verdict matrix as optional"

@D cx_paper_violation := "violating paper immediately revoked" :: workflow [required active]
  do   = "violating paper (cx_paper_gate / significance fail) revoked immediately — PAPER/<slug>/ removed"
  dont = "keep violating paper as draft · mark WIP · defer revocation · allow gate-failure residual"

@D cx_paper_one_per_domain := "per group: 1 positive + 1 closed-negative canonical — ECON · SAFETY · OPS · SUBSTRATE" :: workflow [required active]
  do   = "per group max 1 positive + max 1 closed-negative · replace in place when stronger lands"
  dont = "two+ positive OR two+ negative per group · paper backlog · fork same-group narratives"

@D cx_discovery := "discovery runs continuously, not only at cycle tail" :: workflow [required active]
  do   = "interleave `/kick` / `/gap` discovery every batch — a discovery lane runs alongside verify"
  dont = "defer discovery to the end · single tail-only round · stop discovering once a paper ships"

@D cx_discovery_log := "discoveries persist at .discoveries/<slug>.tape" :: workflow [required active]
  do   = "log every kick/gap discovery to `.discoveries/<slug>.tape` — id · seed · verdict-tier-target"
  dont = "discard discovery output · paraphrase findings · skip linking discovery → next-cycle claim"

@D cx_lab_sandbox := "LAB experiments all run on the SANDBOX substrate" :: workflow [required active]
  do   = "every LAB/<id> routes its LLM calls to the self-hosted SANDBOX substrate (local llama-server)"
  dont = "LAB experiment on an external paid API · skip substrate routing · untracked endpoint"

@D cx_lab_falsifiable := "every LAB experiment states a falsifier" :: workflow [required active]
  do   = "each LAB/<id> = 1 table row + falsifiable hypothesis + explicit falsifier + status glyph"
  dont = "non-falsifiable 'play' note · experiment with no measurable falsifier · untracked row"

@D cx_native_io := "native I/O — Go/Rust style fd inheritance, unbuffered first" :: governance [required active]
  do   = "interactive CLI inherits child fds (Go os.Stdout, Rust Stdio::inherit); unbuffered; flush early"
  dont = "wrapper captures live stdout then emits at EOF; output trapped (hexa-run capture bug, now fixed)"

@D cx_drive_minimal := "DRIVE — minimal feature, user-specified only" :: governance [required active]
  do   = "add a DRIVE feature ONLY when the user explicitly names it; keep the test-drive REPL minimal"
  dont = "propose / suggest / auto-add DRIVE features; feature-creep; 'shall I add X?' trailer prompts"
