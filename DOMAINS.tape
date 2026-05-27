# DOMAINS.tape — domain roster (NAME → snapshot path; progress/goal stay derived, not stored here)
@V := "domains" :: index

@domain SANDBOX := "./SANDBOX.md"
@domain ECONOMICS := "./ECONOMICS.md"
@domain ENGINE := "./ENGINE/ENGINE.md"
@domain NEUROEXP := "./NEUROEXP/NEUROEXP.md"
# BIODATA retired 2026-05-27 — A1/A2 findings absorbed into lm_foundry/docs/bio-llm.md (verify+verdicts moved to lm_foundry/{verify,verdicts}/)
# ─── AXIS.easy.md candidate domains (2026-05-28 batch · 22 신규) ───
@domain CALIBRATION := "./CALIBRATION/CALIBRATION.md"
@domain HALLUCINATION := "./HALLUCINATION/HALLUCINATION.md"
@domain LONG-CONTEXT := "./LONG-CONTEXT/LONG-CONTEXT.md"
@domain PROMPT-SENSITIVITY := "./PROMPT-SENSITIVITY/PROMPT-SENSITIVITY.md"
@domain ENERGY := "./ENERGY/ENERGY.md"
@domain RAG := "./RAG/RAG.md"
@domain AGENT := "./AGENT/AGENT.md"
@domain CONTAMINATION := "./CONTAMINATION/CONTAMINATION.md"
@domain INSTRUCTION-FOLLOWING := "./INSTRUCTION-FOLLOWING/INSTRUCTION-FOLLOWING.md"
@domain MULTILINGUAL := "./MULTILINGUAL/MULTILINGUAL.md"
@domain FAIRNESS := "./FAIRNESS/FAIRNESS.md"
@domain PRIVACY := "./PRIVACY/PRIVACY.md"
@domain ROBUSTNESS := "./ROBUSTNESS/ROBUSTNESS.md"
@domain TRAINING-DYNAMICS := "./TRAINING-DYNAMICS/TRAINING-DYNAMICS.md"
@domain DATA-EFFICIENCY := "./DATA-EFFICIENCY/DATA-EFFICIENCY.md"
@domain HW-VARIANCE := "./HW-VARIANCE/HW-VARIANCE.md"
@domain BATCH-COMPOSITION := "./BATCH-COMPOSITION/BATCH-COMPOSITION.md"
@domain RELIABILITY := "./RELIABILITY/RELIABILITY.md"
@domain CARBON := "./CARBON/CARBON.md"
@domain TEMPORAL := "./TEMPORAL/TEMPORAL.md"
@domain DIVERSITY := "./DIVERSITY/DIVERSITY.md"
@domain USER-MODEL := "./USER-MODEL/USER-MODEL.md"
@domain MULTIMODAL := "./MULTIMODAL/MULTIMODAL.md"

# ─── driving lane (실제 wire 구현) — ENGINE 은 line 6 core sibling 으로 등록됨 (active) ───
# CODEX archived 2026-05-28 (cycle-10 reorg) — 22 candidate first-probe orchestrator 역할 종료.
#   각 candidate 가 독립 도메인 (A1·B·N⭐ 자체 보유 · 위 roster 등록) → meta-orchestration 중복.
#   8-round retrospective history 는 CODEX/CODEX.log.md 에 보존 (archive · active roster 제외).
#   무게중심 이동: CODEX (측정 카탈로그 meta) → ENGINE (driving lane · mature finding → 실제 LLM behavior wire).
# FRONTIER retired 2026-05-28 (cycle-10 reorg) — 6 frontier sub-axis 를 기존 도메인 N⭐ NOVEL MAIN 으로 분산 흡수:
#   F1 SPARSE-MOE→ENERGY/N1 · F2 MULTIMODAL→MULTIMODAL/ 신규 · F3 AGENTIC-TRAJ→AGENT/N1
#   F4 REASONING-DEPTH→HALLUCINATION/N1 · F5 COST-PERF→ECONOMICS/N1 · F6 ALIGNMENT-FAKING→ROBUSTNESS/N1
#   train/infer/serve stack 빈칸 (Phase 3): CHECKPOINT→RELIABILITY/N1 · QUANT→ENERGY/N2 · TOKENIZER→MULTILINGUAL/N1
#   SPECULATIVE→BATCH-COMPOSITION/N1 · DISTRIBUTED→HW-VARIANCE/N1 · KV-CACHE→LONG-CONTEXT/N2
