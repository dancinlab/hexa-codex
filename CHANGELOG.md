# Changelog — hexa-codex

All notable changes to this standalone repo are documented here.
Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/);
versions follow [SemVer](https://semver.org/spec/v2.0.0.html).

## [Unreleased] — AI 지식 codex(239) + frontier-gap 측정 (2026-06-22)

- **ECONOMICS 비용지수 T4 실측 — 표준 roofline/Chinchilla로 설명됨** — SANDBOX scale-ladder
 실벤치 + 폐형 OLS 재계산으로 비용지수의 경험검증을 닫음. ① 추론: 실측 params-축 비용 ∝ N^~1
 (메모리대역/roofline; decode-latency p=0.82·TTFT p=1.02·mem p=0.83; context-축 τ̂≈0.52).
 ② 학습: 실측 compute-지수 1(고정데이터)~2(compute-optimal Chinchilla N∝C^0.5). ③ 품질:
 4-rung free-fit α≈0.21, CI가 넓어 일반 Chinchilla 멱법칙과 구분 불가. 결론: 비용 곡선은
 **표준 roofline/Chinchilla 법칙으로 이미 설명됨**. raw:
 `.verdicts/sandbox/econ_{infer,quality,train}_empirical.txt`. ARCHITECTURE.json economics 잎 갱신.


- **frontier-gap #1 OPS·#2 VLM 심화 측정 통합** — ① OPS 이종-μ R≥3 꼬리 확장: 3번째 물리 박스 부재로
 mini 단일 박스(Metal-fast vs CPU-1thread-slow)에서 R=3.26 합성 측정 — gain 1.91 vs G_het 2.13(편차 −10.3%,
 ±20% 밴드 내), ≥1.5 유지·1.0×로 미붕괴 → 라우팅-우선 deviation이 꼬리까지 지속. 정직 nuance: R≥3에서 dev
 부호가 음수(equal-RR lockstep의 head-of-line-block로 측정 gain이 solo-μ G_het보다 10-15% 축소) — 진짜 3번째
 느린 박스면 tracking 조밀해질 것. 🟢 KEEPS-LANE-OPEN. ② VLM strict-CONFIRM 미도달: LLaVA-NeXT-7B 실격
 (7B≠~3B + subitizing 0.81<0.90 약한 generic counter), Phi-3.5-V/moondream2/gemma-3-4b 전부 transformers-5.8
 hard-unloadable(cache 충돌/nan logits/gated) — 억지 우회 안 함. Qwen-7B control이 recovery 재확인(3B 0.60→7B 0.70).
 InternVL3 1개만 적격 유지 → 🟠 SUPPORTED, lane OPEN(CONFIRMED엔 pinned transformers<5.0 또는 PaliGemma-3B 필요).
 raw: `.verdicts/sandbox/n1_ops_heterogeneous_mmc_measured.txt`(R≥3 rung) · `n2_substrate_counting_family.txt`(6-rung).
 ARCHITECTURE.json frontier-gap 잎 (1)·(2) 갱신.


- **SUBSTRATE VLM counting non-monotone — 🟠 H1′ SUPPORTED / H2 REFUTED (측정)** — 비-Qwen 독립
 아키텍처 InternVL3가 V자 곡선을 완전 재현(subitizing 1-4=1.00 → count 5-9 2B에서 0.65 dip[Qwen2.5-VL-3B
 0.60과 매칭] → 8B에서 0.90 recovery). 2-3B dip이 교차-아키텍처 → "Qwen2.5-VL-3B 국소 artifact(H2)"
 반증, hard-ceiling도 계속 반증(규모에서 회복). strict-CONFIRMED는 아님 — clean 비-Qwen ≥2 family 필요하나
 Phi-3.5-vision 로드 실패(transformers-5.8 DynamicCache 비호환)로 InternVL3 1개만 적격 → SUPPORTED, lane OPEN.
 'subitizing' 라벨 VALIDATED(강 perceiver 전부 1-4=16/16; SmolVLM2는 1-4 자체 0.50 → generic 결함으로 실격).
 dense 10-15 = family-orthogonal hard wall. raw: `.verdicts/sandbox/n2_substrate_counting_family.txt`.
 ARCHITECTURE.json frontier-gap 잎 (2) 측정값 갱신.

- **ai-knowledge codex 239개념 ARCHITECTURE.json 통합** — 7개 도감을 병렬 리서치 에이전트로
 편찬해 `ai-knowledge` 도메인 노드로 제본: ml-foundations 59(역전파·경사하강법·어텐션·트랜스포머·
 MoE·RLHF·양자화) · frontier-models 26(14 crowded-axes + 12 패밀리: DeepSeek V4·Qwen3.x·GLM5.2·
 Kimi K2.6·MiniMax M3·**Gemma 4**·Llama 4·Mistral·gpt-oss·OLMo·Phi·Cohere) · agents-reasoning 30 ·
 multimodal 28 · systems-history 31 · llm-eval 33 · ai-safety 32. Gemma 4 실재 확인(2026-06-03
 12B Unified). raw: `state/scratch/{ml-foundations,frontier-models,agents-reasoning,multimodal,
 systems-history,llm-eval,ai-safety}.json`. JSON valid · docs:ok.



- **frontier-gap novelty 노드를 현 측정상태로 갱신** (단일 SSOT, c4) — scratch
 `frontier-gap.json`의 3 novel lane 상태를 `ARCHITECTURE.json` HEXA_CODEX umbrella의
 `frontier-gap` note(이 노드가 SSOT, scratch는 raw detail)로 정리. (1) OPS heterogeneous-μ
 Erlang-C **🟢 SUPPORTED-MEASURED**: closed-loop-per-host 4-ratio fire에서 weighted/equal
 gain이 `G_het=Σμ/(c·μ_min)`을 1-5% 내 추종(R1 control 0.988× · R2 1.69×@R2.34 · R3 1.66×@R2.48),
 homogeneous 1.0× 평탄 아님 → routing-first deviation 정량 확정, KEEPS-LANE-OPEN(R≥3 tail =
 3rd 느린 박스 미측정). raw: `.verdicts/sandbox/n1_ops_heterogeneous_mmc_measured.txt`.
 (2) SUBSTRATE VL counting 비단조 — 비-Qwen family probe 진행중. (3) lm_foundry out-of-weights
 — 문헌 prior(RouteLLM/HybridLLM/xRouter + function-call catastrophic-forgetting)가 결론 지지,
 $18 재오픈은 confirmatory-only로 cost gate 대기.
- **DLG-mk0 classifier canonical 수치 정정** — `acceptance metrics (r49/r55)` note의 `0.985`는
 r49의 옛 200-task(197/200); canonical은 **0.9833**(r55=r54=r51 300-task, 295/300)으로 surface 일치 갱신.

## [Unreleased] — ARCHITECTURE.json hierarchical `children` decomposition (c4) (2026-06-18)

- **Lossless `children`-tree re-shape (commons c4)** — decomposed the ~49 over-long
 dump cells (`summary`/`note` > ~250 chars or 3+ ` · `-joined items; longest was
 ~2161 chars) into real hierarchical child nodes. Each piled-up cell now exposes a
 short role line on the parent with every item/section unfolded as its own child
 (verb lists → per-verb `module` children; `영구 축` lists → per-axis `lane`
 children; cron/stage/ceiling/sibling/dir dumps → per-item children). **0 chars
 lost** — verified by non-whitespace value char-multiset before vs after (orig ⊆
 new; separators preserved by prepending to the following fragment). Node count
 26 → 301; remaining >250-char cells are all coherent single sentences / parenthetical
 role descriptors / short path anchor lists (NOT dumps), kept per c4. New leaf
 `kind:"note"` (decomposed detail leaf) documented in the root `note` taxonomy.
 Same schema + `children` convention; JSON validates; ARCHITECTURE.html / serve.py
 viewer renders unchanged.

## [Unreleased] — ARCHITECTURE.json tree SSOT migration (2026-06-18)

- **Single design SSOT `ARCHITECTURE.json`** — retired the scattered root domain
 `.md`/`.log.md` docs into ONE AI-parsable architecture tree (mirrors anima #662).
 Schema: `schemaVersion` · `kind:"architecture-tree"` · `title` · `summary` ·
 `note` · `meta{ssot,guard_baseline,migrated_from}` · `columns` · recursive
 `children` with `name`/`summary`/`kind`(구분)/`path`/`status`/`note`. 27 nodes,
 14 top-level (HEXA_CODEX umbrella · 17-verb spec library {SAFETY·ECONOMICS·OPS·
 SUBSTRATE} · lm_foundry {ORCHESTRATION·OPERATIONS·LEARNING_PROGRAMMING·LEARNING_BIO}
 · SANDBOX · Discovery/Claims/Verdicts/Papers · ENGINE/AXIS · LATTICE_POLICY ·
 LIMIT_BREAKTHROUGH · IMPORTED_FROM_CANON · TAPE-AUDIT · CLI/engine · Governance ·
 Not-yet-built · tracked-file delegation).
- **Viewer added** — `ARCHITECTURE.html` (JSON-tree renderer, identical logic to
 anima's) + `serve.py` (stdlib static server, auto-opens the page over http since
 browsers block `file://` fetch). Humans: `python3 serve.py`.
- **Docs RETIRED (`git rm`)** — design content captured in ARCHITECTURE.json,
 histories noted below; recover any old file via `git log`/`git show`:
 - Design snapshots → ARCHITECTURE.json nodes: `ARCHITECTURE.md`, `ECONOMICS.md`,
 `SAFETY.md`, `OPS.md`, `SUBSTRATE.md`, `SANDBOX.md`, `ORCHESTRATION.md`,
 `OPERATIONS.md`, `LEARNING_PROGRAMMING.md`, `LEARNING_BIO.md`, `HEXA_CODEX.md`,
 `LATTICE_POLICY.md`, `AXIS.easy.md`.
 - Audit/provenance docs (were `.log.md`) → ARCHITECTURE.json policy/history nodes:
 `LIMIT_BREAKTHROUGH.log.md`, `TAPE-AUDIT.log.md`, `IMPORTED_FROM_CANON.log.md`
 (live `IMPORTED_FROM_CANON.tape` pointer KEPT).
 - Append-only histories (`<DOMAIN>.log.md`) folded into CHANGELOG/git history —
 every entry preserved in git: `ECONOMICS.log.md` (2065 lines), `OPS.log.md`
 (138), `ORCHESTRATION.log.md` (3554, r40–r72 runtime chronicle), `SAFETY.log.md`
 (423), `SANDBOX.log.md` (3253), `SUBSTRATE.log.md` (310),
 `LEARNING_PROGRAMMING.log.md` (3580, r1–r39 specialist chronicle),
 `HEXA_CODEX.log.md` (empty stub). The load-bearing results/metrics from each
 chronicle are captured in the matching ARCHITECTURE.json node `note` field.
 - Release notes → CHANGELOG: `RELEASE_NOTES_v1.0.0.md` (v1.0.0 SPEC_CATALOG_ONLY,
 17 verbs / 4 groups, extracted from canon@c0f1f570), `RELEASE_NOTES_v1.4.0.md`
 (SANDBOX M5 — 4-group canonical papers + verdicts: ECONOMICS 2-component cost
 model R²=0.997, SAFETY refusal-direction AUROC 0.98 + causal ablation 0.95→0.00 +
 SAE 🔴 honest-negative, OPS M/M/c 18-cell grid λ_max=c·μ, SUBSTRATE non-monotone
 multimodal ladder; τ=4 "falsification" paper REVOKED as self-strawman),
 `V0_6_0_GA.md` (forge code-LLM GA 2026-05-14 r67: r39 specialist 94.29% Mk.I
 strict / 96% 5-NL frozen + r44-r66 orchestration; ~$18.95 line spend; classifier
 98.33% / tier_match 100% / Brier 0.0242; NOT-GA scope cuts: OpenAI key
 unprovisioned, Gemini paid-tier, opus/haiku cross-turn cache zero, specialist
 ceiling v0.7+).
- **Harness setup** — `harness.config.json` `docs.architecture`: `ARCHITECTURE.md`
 → `ARCHITECTURE.json`; allow-list updated (added `ARCHITECTURE.json` +
 `ARCHITECTURE.html`; dropped retired `ARCHITECTURE.md` + `RELEASE_NOTES_v*.md` +
 `V0_6_0_GA.md`). `CLAUDE.md` SSOT pointer/quickref/tree repointed to
 ARCHITECTURE.json (+ `python3 serve.py` for humans). `DOMAINS.tape` SANDBOX +
 ECONOMICS roster rows (the only domain rows pointing at a retired root `.md`)
 repointed to `./ARCHITECTURE.json`. Live `.hexa`/`.py` axis-label strings
 referencing `<DOMAIN>.md` (e.g. `# axis=SANDBOX.md::…`) are provenance — left
 untouched. `ARCHITECTURE/ARCHITECTURE.md` (the distinct ARCHITECTURE
 measurement-axis domain doc under `ARCHITECTURE/`) is NOT the root file — KEPT.

## [Unreleased] — scratch → state/ unification (2026-06-18)

- **Single artifact root `state/`** — absorbed `scripts/scratch/` into
 `state/scratch/` (`git mv` the `.gitkeep`; empty `scripts/scratch/` removed).
 `state/` is the single git-tracked runtime/scratch artifact root (commons c5).
- **Reference fixes (live config paths only)** — `harness.config.json`
 `docs.scratchDir`: `scripts/scratch` → `state/scratch`; `.harness/enforcement.json`
 H-TMP-SCRATCH exception + DOC-SCATTER hints: `scripts/scratch` → `state/scratch`;
 `CLAUDE.md` docs-block scratch pointer + tree `state/` entry. Historical
 provenance strings in code/docs left untouched.
- **Deliberately NOT moved (load-bearing source/output, c9 honest skip)** —
 `.verdicts/` (live write path of ~88 `bench/*.hexa` via `ROOT + "/.verdicts/…"`),
 `bench/` (52 `.hexa` source files cited by 173 refs), `experiments/` (62 `.hexa`
 source experiments cited as provenance by 30 refs). `exports/`, `.harness/`,
 `build/` untouched.
- **.gitignore** — narrow re-ignores after the wholesale `state/` block removal:
 `state/markers/`, `state/*.log`, `lm_foundry/state/*.jsonl` (ephemeral
 run-markers + logs stay untracked; real `state/` artifacts ARE tracked).

## [Unreleased] — harness perfect-setup (2026-06-15)

- **Harness conformance** — brought the repo to full `dancinlab/harness`
 (harness-hardcore) compliance. `.harness-engine` submodule pinned and
 committed; the `bash .harness-engine/bin/harness` wrapper is the canonical
 entrypoint.
- **ARCHITECTURE.md** — replaced the stub with an English architecture SSOT
 (overview + component map + data flow + governance/verify) reflecting the
 17-verb spec library + `lm_foundry/` foundry.
- **CLAUDE.md** — converted from a `project.tape` symlink (tape preserved) to a
 harness-standard markdown guide: H1 + blurb + `## Structure` tree + governance
 summary + `## Harness` + quick reference.
- **harness.config.json** — added `lockdown.files` (core hexa sources) and a
 `docs` block (architecture/log/scratch + `scopeDirs: [""]` root-only +
 allow-list of root SSOT/README-variant docs).
- **.claude/settings.json** — guarded harness hooks confirmed (pre bash/write,
 post edit, prompt, prefs/easy/recommend inject, SessionStart).
- **Docs discipline** — `harness docs check` = `docs: ok`; CLAUDE-MD violations
 0. Prepended an SSOT quickref pointer to 13 scattered root docs.

## [Unreleased] — LAB 재편 + 끼어들기 무손실 실험 + 음성 결과 게재 (2026-05-25)

- **BITNET·RWKV 도메인 → LAB 하위 이동** — 두 도메인 SSOT(`BITNET.md`/`.log.md` · `RWKV.md`/`.log.md`)를 루트에서 `LAB/lab-03-bitnet/` · `LAB/lab-04-rwkv/` 로 `git mv`(히스토리 보존). `LAB/README.md` 인덱스를 "🎓 도메인 졸업(루트)" → "🎓 도메인(LAB 내, SSOT가 `lab-NN-*/<NAME>.md`)" 로 재프레이밍. sibling 링크 `../../` 보정 · `bench/rwkv_m2m3_ctx_sweep.hexa` 주석 경로 갱신. `.verdicts/`·`.discoveries/` 불변 기록은 미수정.
- **LAB-01 끼어들기 무손실 실험 1차 스모크 (✅ SUPPORTED)** — `LAB/lab-01-interrupt-no-loss/interrupt_harness.hexa`. N=12 끼어들기를 세 메커니즘으로 주입: append-only+seq(순차) loss **0/12** · 동시 O_APPEND race loss **0/12** · 단일슬롯 대조군 **11/12** 손실(하니스가 손실을 실제로 탐지함을 증명). SANDBOX Qwen2.5-1.5B echo 12/12(대조군은 환각 노출). 결정론적 `grep|sort` distinct-count 채점(LLM self-judge 아님). LAB-08 stress 후속 백로그 추가.
- **논문 생성 규칙 — 음성 결과(🔴 closed-negative) 게재 허용** — `project.tape` 5개 규칙 개정(sign-gate, user 서명): `cx_paper_gate`(falsified 차단 제거 → CLOSED 티어 🔵🟢🔴 허용, OPEN ⚪🟠🟡만 차단) · `cx_paper_significance`(benefit OR closed refutation) · `cx_paper_format`(§benefit OR §refutation) · `cx_paper_sections`(CLOSED-recompute verdict +falsified) · `cx_paper_one_per_domain`(그룹당 양성1 + 음성1 허용으로 확장). 🔴(결정론적 불일치=닫힌 음성)는 게재, 🟠 INSUFFICIENT/DEFERRED는 여전히 차단.
- **양성 측정 cost model 유지** — 추론비용 latency-fit이 안 맞는다는 내부 verdict `m3_econ_latency_fit.txt` + 양성 측정 cost model `verify/numerics_economics_measured_cost_model.hexa`(wall_ms=370+0.168·tok, R²=0.997, 8/8 🟢). (음성결과 SAE🔴·multimodal은 외부 주장 반증이라 유효.)

## [Unreleased] — inbox/ → INBOX 도메인 이관 (2026-05-24)

- **inbox/ → `INBOX` 도메인 이관** — cross-project handoff 를 `inbox/<kind>/<slug>.md` 폴더에서 repo 루트의 `INBOX` 도메인 1쌍(`INBOX.md` 스냅샷 + `INBOX.log.md` append-only 로그)으로 전환 (pool · sidecar 의 inbox→INBOX 폐기와 정합 · `cd <repo> && /domain set INBOX` 로 관리). 기존 2건 이관 — 열린 1건(sidecar/pool-route mac-only tool escalation, cycle-13)은 `INBOX.md` 에 `- [ ]`, 해소된 1건(hexa-lang runtime_core.c clang forward-decl, VERIFIED-RESOLVED)은 `INBOX.log.md` 에 `- [x]`. `inbox/` 폴더 삭제.

## [Unreleased] — ECONOMICS Pareto envelope (2026-05-23)

Third ECONOMICS-specific cross-cutter — closed-form Pareto-frontier
geometry of the `(N, D) ↔ (loss, train_cost)` trade-off.

- `verify/numerics_economics_pareto.hexa` (new, 10 checks all PASS)
 — iso-loss contour monotone, Lagrangian optimum `(N/D)^α = A/B`,
 equal-reducible identity at optimum, asymptotic E floor at
 `N = D = 1e50`, poles at `N → 0` and `D → 0`, monotone partials
 `∂L/∂N < 0` and `∂L/∂D < 0`, and the iso-cost hyperbola
 `N·D = const`.
- `tests/test_numerics_economics_pareto.hexa` (new companion).
- `verify/report_economics_ladder.hexa` updated — cross-cutter row
 2/2 → 3/3 (now includes pareto), inventory ≥ 17 → ≥ 18.
- Meta wiring: `verify/run_all.hexa` (41 → 42 subjects),
 `verify/lint_numerics.hexa` (green core 19 → 20),
 `tests/test_all.hexa` (32 → 33 cases).
- Surface lockstep: `docs/closure_status.md` (cross-cutter 6 → 7,
 §3 ladder 30 → 31, run_all 41 → 42, companion 32 → 33) +
 `README.md` (verify badge 41 → 42, T2 numerical 19 → 20,
 cross-cutter 6 → 7 files) + `ECONOMICS.md` / `ECONOMICS.log.md`.

## [Unreleased] — ECONOMICS group ladder report (2026-05-23)

Surfaces the recipe §3 ladder across all three ECONOMICS verbs.

- `verify/report_economics_ladder.hexa` (new, 10 checks all PASS) —
 per-verb closure_pct gate (3 checks), cross-cutter row 2/2,
 T4-stub row 3/3, all-verbs-100% simultaneously, inventory ≥ 17,
 group SSOT + verb spec dirs, plus a rendered ladder table.
- `tests/test_report_economics_ladder.hexa` (new companion).
- Meta wiring: `verify/run_all.hexa` (40 → 41 subjects) +
 `tests/test_all.hexa` (31 → 32 cases). NOT wired into
 `lint_numerics.hexa` (this is a meta report, not a numerics_*
 script).
- Surface lockstep: `docs/closure_status.md` (new "Group ladder
 reports" row, §3 ladder 29 → 30, run_all 40 → 41, companion 31
 → 32) + `README.md` (verify badge 40 → 41, new ladder-reports
 inventory row + table) + `ECONOMICS.md` / `ECONOMICS.log.md`.

## [Unreleased] — ECONOMICS quality_scale verification ladder (2026-05-23)

The `quality_scale` verb (3rd ECONOMICS verb — a loss-surface
cross-cutter beside `train_cost` and `infer_cost`) gains its full
T1+T2+T3 verification ladder, reaching recipe §3 closure.

- `verify/calc_quality_scale.hexa` — T1 algebraic floor (8 checks):
 the Chinchilla loss-fit `loss = E + A·N^-α + B·D^-β`.
- `verify/numerics_quality_scale.hexa` — T2 numerical (10 checks):
 loss-surface shape — monotone decreasing in N and D, floored at E,
 asymptotic to E.
- `verify/numerics_quality_scale_solver.hexa` — T2 ODE solver (10
 checks): Euler / midpoint / RK4 re-derivation of `dR/du = -α·R`.
- `verify/numerics_quality_scale_parity.hexa` — T3 published-exponent
 parity (10 checks): comparison against the Kaplan-2020 and
 Hoffmann-2022 (Chinchilla) measured loss-scaling exponents.
- Companion regression tests under `tests/test_*quality_scale*.hexa`.
- Inventory bookkeeping: `verify/lint_numerics.hexa` green core 14→17,
 `verify/run_all.hexa` 34→38 subject scripts, `tests/test_all.hexa`
 cases.

## [Unreleased] — root `.md` spec/history split (2026-05-22)

Per-domain spec/history file split applied to root-level `*.md` (commons
`@D g29` pattern, mirrors sidecar `d705a98` + demiurge). Spec-flavoured
files (`README.md`, `LATTICE_POLICY.md`, `CHANGELOG.md`, `RELEASE_NOTES_v1.0.0.md`,
`CLAUDE.md`) stay current-state-only; history-flavoured files move to
`.log.md` so spec readers stop tripping on dated audit prose.

- `IMPORTED_FROM_CANON.md` → `IMPORTED_FROM_CANON.log.md` (one-time canon
 extraction record, entirely history).
- `LIMIT_BREAKTHROUGH.md` → `LIMIT_BREAKTHROUGH.log.md` (Wave M dated
 real-limits audit, not a live spec).
- `TAPE-AUDIT.md` → `TAPE-AUDIT.log.md` (`.tape` v1.x adoption snapshot
 ledger).
- In-repo references updated in `README.md`, `lm_foundry/README.md`,
 `verify/run_all.hexa`, `papers/plan-coverage-matrix.md`,
 `IMPORTED_FROM_CANON.tape`, `lm_foundry/papers/plan-feedback-channel-ops.md`.
- Past CHANGELOG entries that reference the old names left as-is
 (historical surface per commons `@D g29`).

## [Unreleased] — `lm_foundry/` absorbed from `hexa-forge` (2026-05-13)

The standalone `hexa-forge` repo (domain-LLM foundry — research + recipe +
training substrate) is **merged into this repo as the `lm_foundry/`
top-level component** and the `hexa-forge` repo is retired. `hexa-codex`
already served as forge's sister (serving/inference); the two are now one.

- `lm_foundry/` — entire forge working tree minus dancinlab-wide dupes
 (`AGENTS.md` / `LATTICE_POLICY.md` / `LIMIT_BREAKTHROUGH.md` / `LICENSE`
 / `CITATION.cff` — codex root holds those) and minus log/state dirs.
 Contents: `LEARNING_PROGRAMMING.md` (the code-LLM knowledge SSOT, 14
 sections), `LEARNING_BIO.md`, `ROADMAP.md` (r1–r37 narrative), `papers/`
 (design docs incl. `spec-lever4-compile-rl.md`), `tool/` (SFT/RL dataset
 builders + trainers + scorers), `eval/` (665-task Mk.I + 25-task 5-NL),
 `cli/`, `docs/`, `bench-cold/` (gitignored), `datasets.toml`, `IDEA.md`
 (gitignored).
- **Code-LLM state at absorption**: v0.4.0 GA candidate at **87.67% Mk.I
 strict** (583/665). Path: Qwen2.5-Coder-7B + LoRA r=64 SFT (r1–r34) →
 Phase-A manifest fix → **compile-feedback RL via GRPO (Lever 4)** which
 lifted T4 enum-decl 55→77% (+22pp) — the first decisive RL win in the
 ladder. Gates ③ ④ closed strictly.
- **HF artifacts**: 36 repos under `dancinlab/hexa-forge-*` keep that
 prefix as artifact identity (renaming breaks `from_pretrained` refs in
 published recipes). GA adapter: `dancinlab/hexa-forge-code-7b-qwen2.5-lora-r64-v0.4.0-rl-t4-v2`.

### r38–r41 (2026-05-13) — code-LLM 87.67% → **94.29%** Mk.I, v0.4.x line opened

- **r38 — Lever 4 v3 + T4-body manifest fix (Mk.I 87.67 → 90.98%)**.
 Augmented `tool/build_rl_t4_prompts.py` (20→30 specs incl. eval-residual
 Option/Result/Validated/Tree, 67%→80% generic-bait, 5 epochs); manifest
 Phase-A on 8 T4 body-generic prompts (Vec<String>→StringList,
 Box<Tree<T>>→Tree). Vast A100 40GB CZ ~$2.1/3h20m. **T4 89→100%** 🎯;
 Lever 4 CLOSED.
- **r39 — T3 quote-fragility patch + §12 delegation spec (Mk.I 90.98 → 94.29%)**.
 `tool/build_sft_t3_patch.py` 30 quoted-date pairs + `train_sft_lora.py`
 `--adapter-in` flag for continue-SFT. 13.25 s train, ~$0.7. **T3 58.8→100%**
 🎯🎯, T8 +2.5pp bonus. Parallel: drafted `papers/spec-delegation-v0.4.0.md`
 (354 lines — token grammar + runtime contract + redaction + streaming UX +
 routing-eval). r39 follow-up landed the v0.4.0 scaffolding: 200-task
 `eval/delegation-mk0/manifest.jsonl` + 5-subscore `score_delegation_mk0.py`
 + 580-line `forge_runtime.py`.
- **r40 — v0.4.0 SFT (25% delegation) — labeled experiment, NOT GA**.
 `tool/build_sft_dataset_v18.py` 840-pair delegation block per spec §10.
 ~$0.45/30m. **Every spec §11 gate missed.** T4 100→77% (Lever 4 erased
 by shared-LoRA RL↔SFT conflict — see new memory [[lever4-rl-sft-conflict]]).
 DLG-mk0 overall 0.7652 (vs 0.85 gate).
- **r41 — v0.4.1 rebalanced SFT (9% delegation) — also NOT GA**.
 `tool/build_sft_dataset_v19.py` (v11 base × 2 + 4 new blocks: T4-RL-reinforce
 50, over-delegate-counter 30, refusal-shape 30, OOD-extension 60). Gentler
 recipe: LR 2e-5, 2 ep. ~$1.04/60m. **Every gate again missed.** Five hard
 lessons: SFT-only can't escape specialist↔routing tradeoff in 7B+LoRA.
 **v0.4.2 = routing-RL** queued (GRPO with binary route-correctness reward,
 KL-anchored to r39).
- **GA candidate** (post r39, unchanged through r40/r41):
 `dancinlab/hexa-forge-code-7b-qwen2.5-lora-r64-v0.4.0-rl-t4-v3-t3patch`
 (94.29% Mk.I, 96% 5-NL — pure hexa-canon specialist, no delegation yet).
- **HF repos LIVE: 40** (was 36 at absorption; +rl-t4-v3, +rl-t4-v3-t3patch,
 +v0.4.0-delegate, +v0.4.1-delegate plus 3 bench-cold subdirs per round).
- `.gitignore` extended with `lm_foundry/{runs,logs,bench-cold}/`,
 `lm_foundry/IDEA.md`, `lm_foundry/eval/**/*.bak`, and model-weight
 patterns (`*.safetensors` / `*.gguf` / etc).
- `lm_foundry/eval/hexa-eval/manifest-mk1.jsonl` carries the r37
 T4-struct-variant normalization (12 prompts: `Foo { x: T }` → `Foo(T)`,
 matching hexa-canon which has no struct variants); a v0.4.0-v2 re-score
 against the corrected manifest was running on Vast.ai A100 at absorption
 time — result lands in `lm_foundry/ROADMAP.md` r37 when complete.

## [1.0.0] — 2026-05-06

### Added

- Initial extraction from `canon@c0f1f570` —
 17-verb AI knowledge substrate organized in 4 groups:
 - **safety** (6): alignment, safety, welfare, adversarial, consciousness, interpret
 - **economics** (3): train_cost, infer_cost, quality_scale
 - **ops** (4): deploy, enterprise, agent_serving, eval
 - **substrate** (4): multimodal, rlhf, cog_arch, causal
- `cli/hexa-codex.hexa` — placeholder dispatcher (4-group sub-commands +
 `list` / `selftest` / `help` / `--version` utilities).
- `install.hexa` — hx-package install hook (warn-only selftest at post phase).
- `hexa.toml` — package manifest with 4-group module layout and
 honest-scope `[scope]` block.
- `tests/test_selftest.hexa` — verifies 17-verb presence sweep.
- `LICENSE` — MIT.
- `README.md` — Why / Verbs (4-group table) / Status / Install / Cross-link / License.

### Status

spec `.md` file plus a falsifier preregister; working `.hexa` falsifier
sandboxes are deferred to post-v1.0 cycles.

[1.0.0]: https://github.com/dancinlab/hexa-codex/releases/tag/v1.0.0
