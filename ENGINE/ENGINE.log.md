# ENGINE — log

Append-only history sister of `ENGINE.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.


## 2026-05-28 — cycle-11 GPU fire 3-lane: 축 I1 measured 검증 + 축 N1-loop 자동화 detection half + frontier sweep #1

사용자 "gpu fire · all" — measured lane + cross-session loop 자동화 + frontier 흡수 3개 동시. ubu-1 down · ubu-2 RTX 5070 live · mini 에 qwen2.5-1.5b Q8+Q4 GGUF 둘 다 존재 (이전 cycle-11 blocker "GGUF 없음" 해소).

- [x] **lane 1 (측정) — 축 I1 measured 검증**: ENERGY/N2 quantization wire 의 selector 결정을 실제 추론으로 검증. SANDBOX substrate (mini Apple Silicon Metal · llama-server · `cx_lab_sandbox`) · qwen2.5-1.5b Q8_0 vs Q4_K_M · 15-prompt 결정론적 greedy. 압축 **1.921×** · 속도 **1.376×** · Q4≈Q8 답변 일치 **15/15** (semantic 손실 0 · floor ~6.7pp). ENGINE/I1 "normal budget→Q4" 결정 measured-CORRECT. verifier `ENERGY/verify/measured_energy_n2_quantization_qwen15b.hexa` 🟢 7/7. wire_i1 헤더 + ENGINE.md I1 row + ENERGY.md/log measured 승급. honest residual: full MMLU/GSM8K = deeper frontier OPEN · fp16/int8/q2 disk 부재로 🟡 유지 · Metal-specific tok/s.
- [x] **lane 2 (loop 자동화) — 축 N1-loop detection half**: N1 의 honest residual ("측정이 AUTONOMOUSLY wire 트리거 = STILL UNBUILT") 의 detection 절반 구축. `ENGINE/loop/auto_wire_gap_scanner.hexa` 가 ORPHAN SET = findings − covered 기계 계산 → LIVE 62 findings · 20 wires · 39 ORPHAN (CALIBRATION/A1 의 matrix↔wire gap 까지 검출). 7-CHECK verifier `ENGINE/loop/verify/numerics_engine_loop_gap_scanner.hexa` 🔵 7/7 (synthetic fixture). commits `f1f75e1`→`d4e89ce`. honest residual: gap-detection BUILT · autonomous wire-AUTHORING = NEXT FRONTIER OPEN — N1 은 닫힘 아닌 ONE STEP ADVANCED.
- [x] **lane 3 (frontier 흡수) — sweep #1**: 2026 LLM frontier 스윕 → 6 신규 falsifiable 후보 (UNLEARNING 신규도메인 · sandbagging→ROBUSTNESS/N2 · reward-hack→AGENT/N2 · diffusion-parallel→ARCHITECTURE/N2 · merge-interference→POST-TRAINING/N2 · latent-reasoning→HALLUCINATION/N2). proposal-only · `.discoveries/frontier_2026_*.tape` · commit `fa64c1e`. 우선순위: latent-reasoning (최저비용 첫 probe) · sandbagging (closed-negative 논문감). frontier 무한 — sweep #1 (OPEN/continuation).

## 2026-05-28 — cycle-10 wire: 축 U VERTICAL routing 등재 (12 vertical A1 통합 → task-domain specialist dispatch · 7/7)

ENGINE intake matrix 에 **축 U — VERTICAL 전문 모델 task-domain routing** 신규 등재. axis letter 고갈 (A~T 19 사용 · N=NOVEL) 대응 — 12 vertical 도메인 (CODE·BIO·MATH·LAW·MEDICAL·FINANCE·SCIENCE·ROBOTICS·MATERIALS·WEATHER·CYBERSECURITY + OFFICE generalist) 의 A1 finding 을 single-letter 12개로 낭비하지 않고 **통합 축 U 1개** 로 묶음.

- [x] U1 — `ENGINE/wires/wire_u1_vertical_routing.hexa` + `ENGINE/verify/numerics_engine_u1_vertical_routing.hexa` ✅ **7/7 PASS** · 🔵 STRUCTURAL + 🟡 BY-CITATION. `route_specialist(task_domain, specialist_score_x100) → {<domain>-specialist, generalist}`: domain A1 threshold 충족 시 specialist · 미달 시 OFFICE generalist fallback.
- [x] 12 vertical A1 threshold 통합 (× 100 ledger · libm-free): code oneshot≥30% · bio spec-gain≥10pp · math formal≥50% · law halluc<20%(MAX) · medical conf-wrong<5%(MAX) · finance numeric≥90% · science derive≥40% · robotics transfer≥50% · materials synth≥50% · weather skill≥100% · cyber detect≥60% · general(OFFICE) gap<0.7.
- [x] **safety-critical HARD gate** — medical(conf-wrong ≥5%) · law(halluc ≥20%) · cyber(detect <60%) 미달 specialist 는 REJECT → generalist fallback. falsifier (check 4): confident-wrong 12% 모델을 medical task 에 할당하는 finding-ignorant router 검출 → route_specialist 는 generalist reject (consistency 증명).
- [x] verdict `ENGINE/verdicts/u1_vertical_routing_verdict.txt` (env-driven `_root()`). intake matrix 에 VERTICAL 행 + dispatch surface 에 U1 (route_dispatch + task-domain detector) 추가.
- [ ] 실제 serving vertical routing (lm_foundry `route_dispatch` task-domain 감지 → specialist dispatch · SANDBOX local llama-server) — cost-bearing T4 contact, **cycle-11+ deferred** (`cx_lab_sandbox` · `feedback_closure_is_physical_limit` — rule close ≠ measured close).

## 2026-05-28 — cycle-10 wire: H~T 12 axis 전부 wire `.hexa` 완료 (driving lane 19-axis · 4 batch)

ENGINE intake matrix 의 흡수 12 axis (H~T) wire `.hexa` (finding → 실제 LLM behavior decision rule) 전부 7/7 PASS. 4 batch (cap=3) 순차 · race-guard (explicit pathspec) 무사고.

| batch | axis | wire | commit | decision rule |
|---|---|---|---|---|
| 1 | H ENERGY/N1 | MoE model selection | 76ac10f | premium<1000+small-reasoning → dense |
| 1 | I ENERGY/N2 | quant-level selector | 0271a78 | argmin_size{loss≤budget} |
| 1 | J AGENT/N1 | trajectory safety gate | d7cbddb | decay<300 → 1-step only |
| 2 | K HALLUCINATION/N1 | CoT-toggle | 7bc315f | Δ<5pp → direct (비용절감) |
| 2 | L ECONOMICS/N1 | cost-router | a74279b | cheapest-sufficient (50× 절감) |
| 2 | M MULTIMODAL/A1 | modality-dispatch | b83ddb4 | gap≥30pp modality 회피 |
| 3 | O ROBUSTNESS/N1 | alignment-monitor | 924b2b2 | gap≥30 → audit_deploy |
| 3 | P RELIABILITY/N1 | ckpt-verify | e110307 | mismatch>0 → reject |
| 3 | Q MULTILINGUAL/N1 | context-budget | 807651f | low-fertility 증액 (burmese 4.8×) |
| 4 | R BATCH-COMP/N1 | speculative-toggle | 11df96f | accept<50% → disable |
| 4 | S HW-VARIANCE/N1 | gpu-count selector | fd4469b | efficiency<70% → stop_scaling |
| 4 | T LONG-CONTEXT/N2 | kv-cache selector | 6243111 | utilization<50% → reject |

### driving lane 완성 — 19 axis

ENGINE intake matrix = 7 sibling (A~G · ECONOMICS·SAFETY·OPS·SUBSTRATE·SANDBOX·NEUROEXP·CALIBRATION) + 12 흡수 (H~T) + N(NOVEL latency) = **19 driving axis**. A~G 는 기존 wire · H~T 12 신규 wire · N 은 self-NOVEL.

각 wire 의 공통 구조: `decision(finding_value) → behavior_action` closed-form + 7-check verifier. **핵심 falsifier (check 4) 패턴**: "finding-ignorant rule" (측정 무시하고 항상 같은 결정) 을 구성해서 실제 rule 과 다름을 검출 → wire 가 measurement 를 honor 함을 증명.

honest residual: 모든 wire 가 closed-form decision rule (🔵+🟡). **실제 LLM serving 연결 (lm_foundry · SANDBOX llama-server · vast.ai) 전부 cycle-11+ T4 deferred** — rule close ≠ measured close ([[feedback_closure_is_physical_limit]]).

- [x] H~T 12 axis wire `.hexa` 7/7 (4 batch)
- [x] K~T 9 axis ENGINE.md `[ ]`→`[x]` flip (H·I·J 는 batch 1 시 flip)
- [ ] 실제 serving 연결 (cycle-11+ cost-bearing) — wire decision rule → 실제 lm_foundry/SANDBOX behavior

## 2026-05-28 — cycle-10 reorg: 12 흡수 N⭐ finding → intake matrix axis H~T 등재 (CODEX archive · ENGINE driving 무게중심)

CODEX archive + FRONTIER retire 후, 흡수된 12 도메인 N⭐ finding 을 ENGINE intake matrix 에 axis letter 부여하여 등재 (N 은 NOVEL 점유 → skip). 사용자 directive: "전부 ENGINE intake matrix 등재하고 순차 wire" + "ENGINE 으로 실제 내꺼 만들어가는 재미".

| axis | source finding | wire target |
|---|---|---|
| H | ENERGY/N1 SPARSE-MOE | MoE active-param-aware model selection |
| I | ENERGY/N2 QUANTIZATION | 양자화 레벨 자동 선택 (품질 budget) |
| J | AGENT/N1 AGENTIC-TRAJECTORY | multi-step plan-execute 안전 게이트 |
| K | HALLUCINATION/N1 REASONING-DEPTH | scratch-pad/CoT inference 토글 |
| L | ECONOMICS/N1 COST-PERFORMANCE | cost-aware model routing |
| M | MULTIMODAL/A1 MODALITY-BALANCE | modality-aware dispatch |
| O | ROBUSTNESS/N1 ALIGNMENT-FAKING | eval-vs-deploy consistency monitor |
| P | RELIABILITY/N1 CHECKPOINT-INTEGRITY | checkpoint resume 자동 검증 |
| Q | MULTILINGUAL/N1 TOKENIZER | tokenizer-fertility-aware context budget |
| R | BATCH-COMP/N1 SPECULATIVE-DECODING | draft-acceptance-aware speculative 토글 |
| S | HW-VARIANCE/N1 DISTRIBUTED-SCALING | scaling-efficiency-aware GPU 배치 |
| T | LONG-CONTEXT/N2 KV-CACHE | paged-attention KV budget |

→ intake matrix 가 7 sibling (A~G) + 12 흡수 (H~T) + N(NOVEL) = **19 driving axis** 확장. wire `.hexa` (finding → decision-rule closed-form) 는 순차 batch (cap=3) · 패턴 G1/N1 따라 `ENGINE/wires/wire_<x>1_*.hexa` + `ENGINE/verify/numerics_engine_<x>1_*.hexa`. 실제 LLM 연결 (lm_foundry Mk.I · SANDBOX serving) = cost-bearing cycle-11+ deferred.

- [x] 12 흡수 N⭐ → axis H~T 등재 (intake matrix)
- [ ] 순차 wire batch 1 (H·I·J) · 2 (K·L·M) · 3 (O·P·Q) · 4 (R·S·T)
- [ ] 각 wire 실제 LLM behavior 연결 (cost-bearing cycle-11+)

## 2026-05-28 — cycle-10 round-1 ENGINE intake matrix 확장: axis G CALIBRATION promote + 19 wire stub · race-avoid 2 deferred

`/cycle-bg` cycle-10 round-1 (post-22/22 closure). CODEX 22 candidate sibling 중 첫 🟢 SUPPORTED-NUMERICAL 도달 후보인 **CALIBRATION/A1 (ECE closed-form · Naeini 2015 · Guo 2017 · cycle-9 round-1 · 7/7 PASS)** 을 ENGINE intake matrix 의 **신규 axis letter G** 로 승격. 나머지 21 후보는 `## ENGINE intake (wire stub)` 섹션을 각 snapshot 에 plant (next axis letter H/I/J... 후보 frontier 선언).

### Step 2 — axis G promote (SPEC only, wire .hexa 작성 deferred)

| axis | sibling | wire | verifier | verdict | tier |
|------|---------|------|----------|---------|------|
| G1 (신규) | CALIBRATION | (cycle-10 후속 라운드 deferred) | `../CALIBRATION/verify/numerics_calibration_a1_ece_formula.hexa` | `../CALIBRATION/verdicts/` | 🟢 SUPPORTED-NUMERICAL (CODEX cycle-9 round-1 source) |

- driving target: SANDBOX serving stack 의 inference-time decoding temperature 자동 선택 + confidence-thresholded abstention/refusal.
- ENGINE.md 변경: (a) 영구 축 section 에 `### 축 G — CALIBRATION finding → decoding temperature / confidence-thresholded refusal driving` 추가, (b) sibling intake matrix 에 CALIBRATION 행 추가, (c) Dispatch surface 표 에 G1 행 추가, (d) Cross-refs 6 sibling 도메인 + CALIBRATION verdict 링크 + CODEX 메타도메인 링크.
- N1 latency ledger 후보 데이터 포인트: ΔM=0 (CALIBRATION A1 spawn=cycle-9 round-1 → ENGINE G promote=cycle-10 round-1, sibling-cycle 카운터 기준 인접 cycle = fastest loop · same-session class).

### Step 3 — 19 wire-stub deployment (race-avoid 2 deferred)

각 후보 snapshot 의 `## ENGINE intake (wire stub)` 섹션 = (a) 🟠 deferred status · (b) A1 falsifier verbatim · (c) anticipated ENGINE behavior wire one-liner · (d) CALIBRATION reference 패턴 path. 19/19 stub `=1` 검증 통과.

| domain | falsifier · wire hint (요약) |
|---|---|
| AGENT | 1-step tool < 70% → tool-routing aware plan-execute decoupling |
| BATCH-COMPOSITION | random vs sorted > 30% → length-sorted bucketing |
| CARBON | region 감소 < 20% → grid-aware region routing |
| CONTAMINATION | n-gram > 30% → contamination-discounted scoring |
| DATA-EFFICIENCY | curriculum < 5% → curriculum-order training schedule |
| DIVERSITY | self-BLEU > 0.8 → repetition-penalty auto-tune |
| ENERGY | tokens/J > SOTA×2 → tokens/J budget aware selection |
| FAIRNESS | gap > 10pp → group-gap aware re-weighting |
| HALLUCINATION | rate > 20% → confidence-thresholded abstention |
| INSTRUCTION-FOLLOWING | 준수 < 90% → constraint-aware decoding |
| LONG-CONTEXT | 64k < 4k×0.5 → effective-context-window budget |
| MULTILINGUAL | low-resource < EN×0.5 → per-language tokenizer pick |
| PRIVACY | MI > random+5pp → MI-aware DP-SGD |
| PROMPT-SENSITIVITY | factual < 80% → paraphrase ensemble voting |
| RAG | recall@5 < 50% → retriever-quality gated answer |
| ROBUSTNESS | adv drop > 30pp → adversarial-detection routing |
| TEMPORAL | post-cutoff wrong > 30% → cutoff-aware grounding |
| TRAINING-DYNAMICS | spike > 1/1k → adaptive LR + guarded checkpoint |
| USER-MODEL | drift > 20% → persona-drift gated refresh |

### race-avoid (sibling agents 동시 실행)

- [ ] HW-VARIANCE wire-stub deferred to round-2 (race-avoid — sibling agent 가 동시에 `HW-VARIANCE/` 편집 중, `HW-VARIANCE/HW-VARIANCE.log.md` + `verdicts/` + `verify/` 미커밋 관찰).
- [ ] RELIABILITY wire-stub deferred to round-2 (race-avoid — 동일 sibling agent fan-out 패턴 보호 차원).

### 잔여 (frontier OPEN · perpetual)

- **G1 wire .hexa 작성**: cycle-10 후속 라운드 — `ENGINE/wires/wire_g1_calibration_temperature.hexa` + `ENGINE/verify/numerics_engine_g1_wire_calibration.hexa` (ECE-driven decoding temperature schedule + confidence-thresholded abstention spec).
- **round-2 stub backfill**: HW-VARIANCE + RELIABILITY stub 2개 (sibling agent fan-out 끝난 후).
- **next promote candidate**: 21 후보 중 measured tier (🟢) 도달하는 도메인이 axis letter H 수령. 현재 모두 🔵+🟡 (closed-form + citation) 상태.

## 2026-05-27 — cycle-8 N1 ledger 확장 + 카운터 방법론 교정 · 🟢 7/7 PASS

`/cycle-bg` 라운드 (sticky bg 유지). ⭐ MAIN perpetual 축 N1 을 n=2→6 anchored 로 확장하며 **cycle-5 baseline 의 카운터 혼용 버그를 정직하게 교정**.

| axis | wire | verifier | verdict | tier |
|------|------|----------|---------|------|
| N1 (⭐ MAIN) | `wires/wire_n1_latency_baseline.hexa` | `verify/numerics_engine_n1_latency_baseline.hexa` | `verdicts/n1_latency_baseline_verdict.txt` | 7/7 🟢 SUPPORTED-NUMERICAL |

**버그**: cycle-5 N1 은 A1(ECON)·B1(SAFETY) 를 둘 다 wire-equiv=34(ECON 카운터)로 매핑 → B1=14 는 SAFETY 카운터와 무관한 혼용값. sibling 카운터 incommensurable (ECON=51·OPS/SUB/SAND=29·SAFETY=30·NEX=13).

**교정**: ΔM = `(sibling 자기 카운터 wire-time cycle) − discovery`.

| axis | sibling | disc | wire@ | ΔM | |
|------|---------|------|-------|-----|---|
| A1-spawn | ECON | 27 | 34 | 7 | BOTTLENECK |
| A1-mature | ECON | 34 | 34 | 0 | fast (최속) |
| C1 | OPS | 28 | 29 | 1 | fast |
| D1 | SUB | 28 | 29 | 1 | fast |
| E1 | SAND | 28 | 29 | 1 | fast |
| F1 | NEX | 11 | 13 | 2 | fast |
| B1 | SAFETY | 20 | (미기록) | ≤10 | UNANCHORED·제외 |

**발견 뒤집힘**: mean ΔM=**2.0** · max=7 · 병목(>5)=**1/6** (cycle-5 의 2/3 → 교정). human-in-loop 병목은 **STARTUP artifact** (A1-spawn, paper-mature-gate 이해 전); 최근 cross-domain wire 4개 모두 ΔM 1-2 = FAST. 루프는 이미 빠름. **instrument 개선**: 이제 각 wire 가 sibling-cycle-at-wire stamp (pre-instrumentation gap 닫음). B1 retro-anchor 불가 → 정직 제외 유지.

### 잔여 (frontier OPEN · perpetual)

- **BIODATA axis G**: wireable T4 measured finding 대기.
- **cost-bearing fire** (off-domain · sign-off): B1 runtime · C1 2-host · D1 non-Qwen · E1 5-rung · F1 early-exit scaling.
- ⚠ **미커밋 누적 19+ 파일** (cycle-5~8) — 커밋 권장 (bg worktree fan-out 차단 해소).

## 2026-05-27 — cycle-7 axis F 개통: NEUROEXP → inference depth/readout (F1) · 🟢 6/6 PASS

`/cycle-bg` 라운드 (sticky bg 마커 기록). 사용자 지적 — ENGINE intake matrix 가 **5 sibling 만 wire, NEUROEXP/BIODATA 누락** (구조적 gap). NEUROEXP 를 6번째 sibling 축 F 로 개통.

> bg 마커는 향후 라운드용으로 기록; 이번 항목은 **미커밋 cycle-5/6 파일 위에서 ENGINE.md 공유 편집** (`Filesystem:ENGINE.md` 배타) → worktree fan-out 불가 → inline 실행.

| axis | wire | verifier | verdict | tier |
|------|------|----------|---------|------|
| F1 (NEUROEXP) | `wires/wire_f1_neuroexp_depth_readout.hexa` | `verify/numerics_engine_f1_wire_neuroexp.hexa` | `verdicts/f1_wire_neuroexp_verdict.txt` | 6/6 🟢 SUPPORTED-NUMERICAL |

- [x] **F1** — NEUROEXP cycle-11 L2 (logit-lens depth · 🟢 8/8 MEASURED · Qwen2.5-1.5B 28L) → inference-time early-exit/readout selector. emitted rule: readout block=23-28 (final 6) · readout layer=**27 (peak 50.0%), ≠ final 28 (35.7%)** (final RMSNorm de-optimize) · early-exit min=23 (82% depth) · mid-exit@14 unsafe (gap 27.5pp≫5pp). benefit: peak readout +14.3pp vs final · early-exit floor 로 mid-exit 27.5pp loss 회피. class=method-transfer. actual early-exit fire deferred (NEUROEXP scaling Qwen2.5-{0.5,3,7}B × layer · peak/block shift falsifier).

### ENGINE 구조 갱신 (6-sibling intake)

- @goal · North-star diagram · North-star prose · intake matrix · dispatch surface 전부 NEUROEXP 행 추가 (BIODATA = axis G placeholder, wireable T4 measured finding 대기).
- 축 갱신: A(ECONOMICS) · B(SAFETY) · C(OPS) · D(SUBSTRATE) · E(SANDBOX) · **F(NEUROEXP, NEW)** · N(self-meta) — sibling 5→6.

### 잔여 (frontier OPEN · perpetual)

- **BIODATA axis G**: protein/DNA/MedQA 의 wireable T4 measured finding 확보 시 개통.
- **N1 ledger 확장**: 이제 A1·B1·C1·D1·E1·F1 = 6 wire data point — 다음 cheap 라운드에서 n=2→n=6+ 재계산 (sibling current cycle: ECON=51·OPS=29·SUBSTRATE=29·SANDBOX=29·SAFETY=30·NEUROEXP=13).
- **cost-bearing fire** (off-ENGINE-domain · sign-off+도메인 전환 필요): B1 runtime · C1 2-host · D1 non-Qwen · E1 5-rung re-run · F1 early-exit scaling.

## 2026-05-27 — cycle-6 E1 wire (SANDBOX harness auto-gen) · 🟢 6/6 PASS

`/cycle` (sticky fg) 자동-계속 라운드: cycle-5 가 deferred 한 마지막 open milestone E1 실행.

| axis | wire | verifier | verdict | tier |
|------|------|----------|---------|------|
| E1 (SANDBOX) | `wires/wire_e1_sandbox_harness_gen.hexa` | `verify/numerics_engine_e1_wire_sandbox.hexa` | `verdicts/e1_wire_sandbox_verdict.txt` | 6/6 🟢 SUPPORTED-NUMERICAL |

- [x] **E1** — SANDBOX cycle-28 N1 (cross-substrate reproducibility 🟠) → next-cycle harness auto-gen. 모순된 두 input (cycle-23c 16-item/4-rung NON-MONOTONE V · cycle-24 50-item/3-rung partial MONOTONE) 을 받아 둘 다 dominate 하는 confound-free spec emit: **5-rung·50-item·24s/item time-cap (wall 1200s)·10/rung balanced·seed=42**. core falsifier held — 5>4 ∧ 5>3 rungs ∧ 50≥16 ∧ 50≥50 → cycle-24 의 incomplete-coverage + no-time-cap confound 재생산 안 함. actual 5-rung SANDBOX fire deferred (SANDBOX N1 mac M3 ~20min $0).

### N1 ledger self-reflexive 갱신

E1 wire 도 cycle-6 신규 data point (ΔM: SANDBOX cycle-28 → ENGINE cycle-6). A1/B1/C1/D1/E1 = 5 sibling axis 전부 first-wire 됨 (B1 SPEC-only, runtime deferred). N1 baseline 재계산은 별도 라운드 (현재 ledger n=2 → 확장 가능 data point 누적 중).

### 영구 축 상태 (5 sibling axis 1차 wire 완료)

| axis | sibling | 1차 wire | cost-bearing fire 잔여 |
|------|---------|----------|----------------------|
| A1 | ECONOMICS | ✅ cycle-1 (router rule) | — (E1 finding mature, same-session) |
| B1 | SAFETY | ✅ cycle-2 SPEC | runtime intervention (rhat-vector · cycle-5 preflight 🟠) |
| C1 | OPS | ✅ cycle-5 (weighted-RR) | 2-host Erlang-C fire (`bench/sandbox_p3_multinode_2host.hexa`) |
| D1 | SUBSTRATE | ✅ cycle-5 (family gate) | non-Qwen-7B rung (InternVL/LLaVA-NeXT) |
| E1 | SANDBOX | ✅ cycle-6 (harness gen) | actual 5-rung 50-item re-run (mac M3) |
| N1 | ENGINE-self | ✅ cycle-5 (latency baseline) | ⭐ MAIN perpetual — wire 마다 ledger 확장 |

**다음 frontier (모든 closed-form 1차 wire 소진 — lane 위로 이동):** 모든 잔여는 **cost-bearing GPU/pod fire** (closed-form 예측을 실측으로 검증) — B1 runtime · C1 2-host · D1 non-Qwen · E1 5-rung re-run. closed-form lane 은 drained, measurement-contact lane 은 OPEN.

## 2026-05-27 — cycle-5 N1·C1·D1 wire batch (/cycle fg) · 🟢 5/5 + 6/6 + 6/6

`/cycle` (sticky fg) 1 라운드: open milestone 4 (C1·D1·E1·N1) 중 cap=3 batch 실행, E1 (harness 코드-gen) 다음 라운드 deferred.

| axis | wire | verifier | verdict | tier |
|------|------|----------|---------|------|
| N1 (⭐ MAIN) | `wires/wire_n1_latency_baseline.hexa` | `verify/numerics_engine_n1_latency_baseline.hexa` | `verdicts/n1_latency_baseline_verdict.txt` | 5/5 🟢 SUPPORTED-NUMERICAL |
| C1 (OPS) | `wires/wire_c1_ops_hetero_scheduler.hexa` | `verify/numerics_engine_c1_wire_ops.hexa` | `verdicts/c1_wire_ops_verdict.txt` | 6/6 🟢 SUPPORTED-NUMERICAL |
| D1 (SUBSTRATE) | `wires/wire_d1_substrate_family_rung.hexa` | `verify/numerics_engine_d1_wire_substrate.hexa` | `verdicts/d1_wire_substrate_verdict.txt` | 6/6 🟢 SUPPORTED-NUMERICAL |

- [x] **N1** — discovery→execution ΔM ledger (manual ∞ → MEASURED): A1-spawn=7 [BOTTLENECK] · A1-mature=0 (same-session, fastest) · B1-mature=14 [BOTTLENECK]. mean=7.0 · max=14 · bottleneck (ΔM>5) 2/3. honest self-measurement: same-session 아닐 때 human-in-loop 병목 — 닫기 = handoff 자동화로 ΔM→0. n=2 anecdotal.
- [x] **C1** — OPS heterogeneous-μ: per-server μ (mini=9.53 · ubu-1=3.0 req/s) → `weighted-round-robin`. λ_max=Σμ_i=12.53 vs slow-server-bound(Whitt 1986)=c·μ_min=6.0 → 예측 gain **2.09×**. single-UMA 도 dominant-slow-server 도 아님. 2-host 실측 deferred (OPS N1 ±15%).
- [x] **D1** — SUBSTRATE family-confound: Qwen-only ladder → `INSUFFICIENT for family-universal`; mixed (≥2 family + non-Qwen>0) → `ADMISSIBLE`. cycle-28 family-slope gap=0.49>0. core falsifier held (Qwen-only 절대 universal 아님). non-Qwen-7B 실측 deferred (InternVL/LLaVA-NeXT).
- [ ] **E1** — SANDBOX next-cycle harness auto-gen: 이번 batch deferred, 다음 라운드.

### N1 ledger self-reflexive 갱신

C1·D1 wire 둘 다 cycle-5 신규 data point — 다음 N1 재계산 시 ledger n 확장. cross-domain NOVEL 정책: C1↔OPS-N1 · D1↔SUBSTRATE-N1 의 sibling-N1 이 measured fire 를 emit 하면 wire 재검증.

### 잔여 (frontier OPEN · perpetual)

- **E1** 다음 라운드 (harness 코드-gen).
- **cost-bearing fire** — C1 2-host (`bench/sandbox_p3_multinode_2host.hexa`) · D1 non-Qwen-7B rung · B1 runtime (rhat-vector) 모두 GPU/pod 필요, 별도 fire 라운드.
- **새 sibling finding** land 시 새 axis cell 추가 (frontier 종료 아님).

## 2026-05-27 — cycle-4 B1 runtime PREFLIGHT · 4/5 assets present · 🟠 PARTIAL (gap=rhat-vector)

ENGINE 네번째 fire. B1 axis 의 cycle-2 SPEC wire 는 SPEC-only 였고 actual runtime fire (load 모델 + register forward hook + 측정 adv/benign refusal rate) 는 cost-bearing 으로 cycle-5+ 로 deferred 되어 있던 상태. 이 cycle-4 = 그 cycle-5 fire 의 readiness 를 측정하는 **closed-form PREFLIGHT** — 어떤 자산이 이미 존재하고 어떤 게 빠졌는지 GAP REPORT 생성. 모델 load · venv install · activation capture 모두 절대 안 함 (read-only filesystem + pool probe 만).

### 산출물

- [x] `ENGINE/verify/numerics_engine_b1_runtime_preflight.hexa` — 5-asset survey, 각 asset 마다 1 check, READ-ONLY exec() probes (`pool on ubu-1 "ls ..."` · `find` · `grep`); `_root()` upstream-walk pattern 재사용 (a1 verifier 와 동일 idiom). 모델 다운로드 · venv 설치 · activation 캡처 절대 안 함.
- [x] `ENGINE/verdicts/b1_runtime_preflight_verdict.txt` — readiness=🟠 PARTIAL · 4/5 assets · gaps=rhat-vector · per-asset PASS/FAIL breakdown.

### Asset survey 결과 (4/5 PASS)

| # | Asset | Status | Detail |
|---|-------|--------|--------|
| 1 | Qwen2.5-1.5B-Instruct 모델 | ✅ PASS | ubu-1 HF cache `~/.cache/huggingface/hub/models--Qwen--Qwen2.5-1.5B-Instruct` 존재. Mac local 은 base + GGUF Q4/Q8 만 (Instruct fp32 없음 — 상관 없음, ubu-1 에서 fire) |
| 2 | r̂ direction vector (full 1536-dim) | ❌ FAIL | 현재 commit 된 SoT 는 `m2_safety_refusal_norms.tsv` 84-col **NORMS** + `causal_ablation_summary.json` **scalar dir_norm** 만; cycle-19 의 transient 1536-dim hidden-state direction 은 ablation 후 폐기됨. cycle-5 fire 의 STEP-1 으로 재추출 필요 (= fire 자체에 internal) |
| 3 | 40-prompt adv+benign set | ✅ PASS | `bench/sandbox_stage4_refusal_matrix.hexa` (20 adv 4 categories × 5: hate · violence · self_harm · medical_advice_risk) + `bench/sandbox_m5_safety_causal_ablation.hexa` L66-67 의 ADV/BENIGN tuple. PRIVATE per cx_hf_safety_private (in-source committed, HF 미등록). Task brief 의 "200-sample" 은 canonical 40 의 misstatement — 40 으로 fire 가능, 200-scaling 은 cycle-5b 별도 asset |
| 4 | HF transformers clean venv | ✅ PASS (변형 인정) | `~/venv-hf-clean` 없음, 대신 `~/sandbox_probe/venv` 가 transformers==4.51.3 + numpy==1.26.4 (= reference_activation_capture_env 의 pin) — cycle-19 causal_ablation 이 실제로 쓰던 venv. naming 만 다름; pin 일치하므로 동일 환경 |
| 5 | Forward-hook + projection-out code | ✅ PASS | `bench/sandbox_m5_safety_causal_ablation.hexa` L89-90 이미 `register_forward_hook` 을 embed + 28 decoder layer 전부에 등록, projection-out 라인 `h ← h − (h·r̂)r̂` 본문 포함. cycle-5 fire = 이 harness 를 SPEC layer=19 single-source 로 reduce (현재 3-layer scan 17/18/19) — trivial |

### Readiness 판정

🟠 **PARTIAL** — cycle-5 runtime fire 는 blocked-until=`rhat-vector` 이지만 이 gap 은 **별도 prereq 가 아니라 fire 자체의 STEP-1**. asset 4-5 (venv + hook code) 가 PASS 이므로 새 install / 새 code 없이 cycle-5 가 바로 진입 가능. STEP-1 에서 r̂ 추출 + npy 로 persist (`m5_safety_refusal_direction_L19.npy` 권장) → STEP-2 에서 projection-out 적용 → STEP-3 에서 SPEC ±10pp band 검증 (adv_after ≤ 10, benign_after ≤ 10).

### 영구 axis 원칙 (feedback_closure_is_physical_limit)

- B1 axis 의 `[x]` 상태는 cycle-2 SPEC close 그대로 유지. PREFLIGHT 는 axis flip 아님 — cycle-5+ fire 의 readiness 측정일 뿐.
- frontier OPEN: Qwen-only universal 여부, SPEC tolerance band ±10pp 의 실제 fire 결과, cross-family generalization 모두 SAFETY N1 axis 의 미해결 spawning 잔량 — B1 wire 의 scope 도 그에 따라 재정의 여지 있음.

### N1 latency (3rd data point)

- B1 finding spawn/mature: SAFETY cycle-19/20
- B1 SPEC wire: ENGINE cycle-2 (ΔM_after_mature ≈ 14 sibling cycles)
- B1 PREFLIGHT: ENGINE cycle-4 (ΔM_after_mature ≈ 16 cycles · ΔM_after_wire = 2 cycles)
- runtime FIRE (예상): ENGINE cycle-5+, blocked-until=rhat-vector(in-fire) → ΔM_after_mature ≥ 17

### Cycle-5 진입 권고

`bench/sandbox_m5_safety_causal_ablation.hexa` 의 STEP-1 logic 을 SPEC layer=19 단일-source 로 축소 + r̂ 를 `~/sandbox_probe/` 에 `.npy` 로 persist → mac repo 로 scp → `.verdicts/sandbox/m5_safety_refusal_direction_L19.npy` 로 commit → STEP-2 (projection-out at L19 only) → STEP-3 (refusal rate 측정, SPEC ±10pp 검증 verdict 생성). asset survey 가 양호하므로 새 환경 prep 없음.

---

## 2026-05-27 — cycle-3 ENGINE 도메인 폴더 통합 reorg · 모든 산출물 `ENGINE/` 안으로

**사용자 지시:** "ENGINE/* 폴더 생성후 안에 모두 구현" + "도메인도".
ENGINE 관련 모든 파일을 root-scatter (engine/ · verify/numerics_engine_* · `.verdicts/engine/` · root-level ENGINE.md/log.md) 에서 단일 `ENGINE/` 폴더 안으로 통합. domain-folder convention 첫 적용 (sibling 도메인들은 여전히 root-flat — 추후 사용자 선택).

### 산출물 (git mv preserve history)

| from | to |
|------|------|
| `engine/wire_a1_*.hexa` | `ENGINE/wires/wire_a1_*.hexa` |
| `engine/wire_b1_*.hexa` | `ENGINE/wires/wire_b1_*.hexa` |
| `verify/numerics_engine_a1_*.hexa` | `ENGINE/verify/numerics_engine_a1_*.hexa` |
| `verify/numerics_engine_b1_*.hexa` | `ENGINE/verify/numerics_engine_b1_*.hexa` |
| `.verdicts/engine/a1_*.txt` | `ENGINE/verdicts/a1_*.txt` |
| `.verdicts/engine/b1_*.txt` | `ENGINE/verdicts/b1_*.txt` |
| `ENGINE.md` (root) | `ENGINE/ENGINE.md` |
| `ENGINE.log.md` (root) | `ENGINE/ENGINE.log.md` |

case-fold workaround: macOS APFS case-insensitive + git core.ignorecase=true → ENGINE_tmp 중간 단계 거쳐 ENGINE/ (대문자) 생성.

### 갱신된 path 참조

- `DOMAINS.tape`: `@domain ENGINE := "./ENGINE.md"` → `"./ENGINE/ENGINE.md"`
- `ENGINE/verify/*.hexa` 의 `_root()` 함수: pwd 단순참조 → DOMAINS.tape marker 까지 walk-up (hexa CLI 가 .hexa grandparent dir 로 cd 하는 동작 우회). HEXA_CODEX_ROOT env 가 있으면 그것 우선.
- `ENGINE/verify/*.hexa` 의 `OUT_PATH`: `ROOT + "/.verdicts/engine/..."` → `ROOT + "/ENGINE/verdicts/..."`
- 두 verifier 의 verdict file metadata path 줄들 (`# wire=...`, `# verifier=...`) 모두 새 위치로
- `ENGINE/ENGINE.md` Cross-refs: sibling 도메인 링크 `../<NAME>.md` 로 (sibling 들이 아직 root 에 있음); 새 항목 추가 (`wires/` · `verify/` · `verdicts/` 디렉토리 링크)
- `ENGINE/ENGINE.log.md` 의 12개 path 참조 (cycle-1/2 entry 들의 markdown link 본문 + URL 양쪽) bulk-sed 로 일괄 변환
- `.gitignore`: `ENGINE/build/` 추가 (hexa CLI 가 .hexa 파일 dir 옆에 build cache 생성)

### 검증

- [x] 두 verifier 새 위치에서 re-fire — A1 🟢 5/5 · B1 🟢 6/6 그대로 PASS
- [x] verdict 파일 `ENGINE/verdicts/` 에 정확히 land (첫 시도는 `ENGINE/ENGINE/verdicts/` 이중 경로 버그 발견 → `_root()` 수정 후 fixed)
- [x] sibling 도메인 docs (ECONOMICS.log.md · SAFETY.md 등) 에 ENGINE.md / engine/ 외부 link 없음 — root-level → ENGINE/ 이동이 외부 깨짐 없음

### 영구 axis 의미

cycle-3 reorg 는 axis [x] flip 아님 — 산출물 위치 정리만. A1/B1 axis 의 [x] 상태는 그대로 유지 (각각 cycle-1/2 wire 의 first-fire close). 새 wires 가 ENGINE/wires/ 에 추가되면 같은 패턴.

### 다음 wire 후보 (priority 그대로)

- **cost-bearing B1 runtime fire** (cycle-4+, SANDBOX llama-server hook patch on ubu-1)
- **C1/D1/E1** — sibling NOVEL N1 mature 대기

---

## 2026-05-27 — cycle-2 ENGINE B1 SPEC wire · SAFETY refusal-direction → inference intervention · 🟢 6/6 PASS

ENGINE 두번째 fire. SAFETY cycle-19/20 의 refusal-direction 발견 (Qwen2.5-1.5B
AUROC=0.98 + causal ablation 95→0%) 을 inference-time intervention SPEC 으로 wire.

### 산출물

- [x] `ENGINE/wires/wire_b1_safety_refusal_intervention.hexa` — SPEC 7 fields:
  layer_index=19 · direction_extraction="difference_of_means" ·
  intervention="projection_out" · rank=1 · source_model=qwen2.5-1.5b-instruct ·
  expected_adv_refusal_pct_after≤10 · expected_benign_refusal_pct_after≤10.
  runtime consumer hint emitted (llama-server hook formula 명시).
- [x] `ENGINE/verify/numerics_engine_b1_wire_safety.hexa` — paired falsifier (6 checks):
  - C1: layer_index == 19 ✅
  - C2: intervention=projection_out & rank=1 (Arditi 2024 form) ✅
  - C3: expected_adv ≤ tolerance (10pp) ✅
  - C4: expected_benign ≤ tolerance (specificity 보존) ✅
  - C5: effect-size delta ≥ 80pp ✅ (95pp 실제)
  - C6: per-class avg ≈ overall ground truth ✅ (avg=95, diff=0)
- [x] `ENGINE/verdicts/b1_wire_safety_verdict.txt` — verbatim verdict log

### N1 (MAIN axis) — discovery → wire latency · 두번째 데이터 포인트

| wire | finding source | mature cycle | wire cycle | ΔM_after_mature |
|---|---|---|---|---|
| A1 (cycle-1) | ECONOMICS E1 | cycle-34 (n=11 PARITY) | ENGINE cycle-1 | **0** (same session) |
| **B1 (cycle-2)** | **SAFETY cycle-19/20** | **cycle-20 (v1.4.0)** | **ENGINE cycle-2** | **~14** (hexa-codex global) |

**N1 baseline first table (n=2)**:
- range: [0, 14]
- mean: 7
- reading: human-in-loop bottleneck 가 명확 — SAFETY cycle-19/20 finding 이 14 cycle
  동안 wire 대기 (ENGINE 도메인 자체가 cycle-30 에 init 되기 전엔 wire 받을 곳 없었음).
  A1 는 ENGINE init 이후 첫 ECONOMICS mature 와 same-session 으로 즉시 wire (0 cycle).
  N1 의 falsifier 가정 "ΔM > 5 cycles → human bottleneck 정량화" 가 B1 에서 **충족** —
  자동화 필요 신호 첫 quantification.

### Honest residual

- B1 wire 는 **SPEC-ONLY** — actual llama-server inference hook patch 는 cost-bearing,
  ENGINE cycle-3+ 로 deferred. 그 fire 가 실제 post-intervention refusal-rate 가
  expected band [0, 10]% 안에 떨어지는지 측정 (real validation).
- source finding 자체가 single-model (Qwen2.5-1.5B, n=1) — SAFETY N1 NOVEL axis 가
  cross-family universality 측정 중. N1 이 Qwen-specific 으로 닫히면 B1 wire scope =
  Qwen-only intervention (universal 아님). 그 경우 wire SPEC 의 source_model field 가
  "model-class scoping" 역할 한다는 점이 honest design.
- 외부 anchor: Arditi 2024 (arXiv:2406.11717) Llama-family single-direction mediation.
  SAFETY cycle-19/20 는 Qwen 에서 동형 발견 (replication). cross-family universality
  는 양쪽 모두 일관되면 plausibility 높지만 정량 측정 아직 없음.

### 다음 wire 후보 (priority order)

- **cost-bearing B1 runtime fire** (cycle-3+, SANDBOX llama-server hook patch) —
  SPEC 의 첫 real-validation; N1 의 falsifier band ±10pp 적용.
- **C1 (OPS heterogeneous-μ → multi-node scheduler)** — cycle-28 NOVEL N1 still
  spawning (n=1), wire deferred until mature.
- **D1 (SUBSTRATE family-vs-scale → model selector)** — cycle-28 NOVEL N1 still
  spawning.
- **E1 (SANDBOX cross-substrate → harness auto-gen)** — cycle-28 NOVEL N1 still
  spawning.

### 연결

- input finding: [SAFETY.md (cycle-19/20 refusal-direction)](SAFETY.md) · `.verdicts/sandbox/m4_safety_refusal_*`
- wire: [`ENGINE/wires/wire_b1_safety_refusal_intervention.hexa`](ENGINE/wires/wire_b1_safety_refusal_intervention.hexa)
- falsifier: [`ENGINE/verify/numerics_engine_b1_wire_safety.hexa`](ENGINE/verify/numerics_engine_b1_wire_safety.hexa)
- verdict: [`ENGINE/verdicts/b1_wire_safety_verdict.txt`](ENGINE/verdicts/b1_wire_safety_verdict.txt)
- external anchor: Arditi et al. 2024 (arXiv:2406.11717) · SANDBOX serving stack target

---

## 2026-05-27 — cycle-1 ENGINE A1 first wire · ECONOMICS E1 → router rule · 🟢 5/5 PASS

ENGINE 도메인의 **첫 fire** (cycle-30 init 이후 5 sibling cycle 동안 0/6 axes unfired).
ECONOMICS E1 (MoE active-param scaling-law divergence) 가 cycle-34 에서 n=11 PARITY
4-batch sign preservation 으로 mature → 즉시 ENGINE A1 axis 로 wire.

### 산출물

- [x] `ENGINE/wires/wire_a1_econ_e1_router_rule.hexa` — 13-model registry (4 dense + 9 MoE,
  cycle-26 c1 envelope + cycle-34 e1 landings 통합) · `econ_e1_route(class_label)` 함수
  emits ranked model index list. 2 class lane:
  - `cost_sensitive_chat`: MoE 중 dev_factor > dense median (24.05) 인 small-active 만
    선택, active_B ascending sort (cheapest inference first)
  - `max_quality_research`: dense 만 선택, active_B descending sort (peak quality first)
- [x] `ENGINE/verify/numerics_engine_a1_wire_econ_e1.hexa` — paired falsifier (5 checks):
  - C1: cost top-1 = MoE & dev > dense_median ✅ (Granite-3-3B-A800M, dev=625)
  - C2: cost top-3 avg active < 5B ✅ (avg=1.3B)
  - C3: quality top-1 = dense large (active ≥ 70B) ✅ (Llama3.1-405B, active=405B)
  - C4: deterministic (re-call same output) ✅
  - C5: cost top-1 dev > 2× dense_median ✅ (625 > 48.1, 13× margin)
- [x] `ENGINE/verdicts/a1_wire_econ_e1_verdict.txt` — verbatim verdict log

### N1 (MAIN priority axis) — discovery → execution latency baseline 첫 측정값

| 시점 | cycle | 사건 |
|---|---|---|
| spawn | ECONOMICS cycle-27 | E1 axis 첫 anecdote (DeepSeek-V3 active D/N=20 exact, n=1) |
| mature | ECONOMICS cycle-34 | n=11 PARITY 도달 · 4-batch sign preservation · |z|=0.558 POS |
| wired | ENGINE cycle-1 | 이 wire + falsifier 🟢 5/5 PASS |

**latency reading**:
- ΔM_after_spawn = 7 sibling cycles (c27 → c34 → ENGINE cycle-1)
- ΔM_after_mature = 0 cycles (cycle-34 mature 와 ENGINE cycle-1 wire 가 **같은 세션**)
- baseline 가정: paper-mature gate 까지 기다린 후 즉시 wire 가 가장 honest pattern
  (즉, "spawn → wire" 가 아니라 "mature → wire" 가 의미있는 latency 측정)

### 영구 axis 의미

A1 의 `[x]` flip 은 axis frontier 종료가 아니다 ([[feedback_closure_is_physical_limit]]):
- 이 wire 는 E1 finding 의 첫 cycle-34 PARITY mature 반영
- ECONOMICS E1 가 새 batch (n>11) 또는 다른 finding 으로 진화하면 router rule 재-wire
- ECONOMICS C1/D1 (다른 ECONOMICS axes) 가 mature 되면 ENGINE A1 wire 에 추가 rule
- 즉 A1 axis 자체는 영구 OPEN — 한 finding wire 가 첫 데이터 포인트일 뿐

### 다음 wire 후보 (priority order, ENGINE 다른 axes)

- B1 (SAFETY refusal direction → inference-time intervention) — cycle-19/20 finding 이
  이미 mature 상태이므로 즉시 wire 가능; SANDBOX llama-server 의 inference-time hook
  필요. ΔM_after_mature 측정 두번째 데이터 포인트.
- C1 (OPS heterogeneous-μ → multi-node scheduler) — cycle-28 NOVEL N1 still spawning
  (n=1), wire 는 mature gate 후로 deferred.
- D1 (SUBSTRATE family-vs-scale → model selector) — cycle-28 NOVEL N1 still spawning.
- E1 (SANDBOX cross-substrate → harness auto-gen) — cycle-28 NOVEL N1 still spawning.

### 연결

- input finding: [ECONOMICS.log.md cycle-34](ECONOMICS.log.md) (n=11 PARITY entry)
- wire: [`ENGINE/wires/wire_a1_econ_e1_router_rule.hexa`](ENGINE/wires/wire_a1_econ_e1_router_rule.hexa)
- falsifier: [`ENGINE/verify/numerics_engine_a1_wire_econ_e1.hexa`](ENGINE/verify/numerics_engine_a1_wire_econ_e1.hexa)
- verdict: [`ENGINE/verdicts/a1_wire_econ_e1_verdict.txt`](ENGINE/verdicts/a1_wire_econ_e1_verdict.txt)
- ECONOMICS source: [`ECONOMICS.md::E1`](ECONOMICS.md)
- N1 axis (self-meta): [`ENGINE.md::N1`](ENGINE.md)

---

## cycle-30 — ENGINE 도메인 init (6번째 orthogonal group)

**사용자 지시:** "실제 발견에 따라 차후 실제 LLM 진행시킬 엔진 같은것도 필요한데 도메인 만들자". cycle-21~29 의 5 sibling 도메인 NOVEL findings 를 실제 LLM 학습·추론·serving 행동 변경으로 closed-loop driving 하는 6번째 orthogonal group.

### Init artifacts

- `ENGINE.md` (full SSOT, 6 영구 axes + Sibling intake matrix + Dispatch surface + Honesty invariants + Cross-refs)
- `ENGINE.log.md` (이 entry)
- `DOMAINS.tape` roster: `@domain ENGINE := "./ENGINE.md"` 자동 등록

### 6 영구 축 + NOVEL N (MAIN priority)

| axis | driving target | sibling source |
|------|----------------|----------------|
| A1 | lm_foundry router | ECONOMICS C1/E1 |
| B1 | SANDBOX inference-time intervention | SAFETY refusal direction |
| C1 | multi-node scheduler | OPS M/M/c + N1 heterogeneous-μ |
| D1 | model selector | SUBSTRATE family-vs-scale |
| E1 | bench harness auto-gen | SANDBOX cross-substrate |
| **N1 ⭐** | **discovery→execution latency** (ENGINE self-NOVEL meta) | meta-self |

### 진행도 = 0/6 (모두 [ ] open, perpetual frontier 유지)

frontier closure 아님 — sibling 도메인의 새 finding 마다 새 cell 추가 (A1', B1'…).
N1 = MAIN priority lane (cycle-28 cross-domain NOVEL 정책 일관).

### Honest residual (init 단계의 한계)

- driving 자동화 0건 — 모든 5 axis 가 cycle-30 시점에 manual loop (sibling finding 발견 후 사용자가 ENGINE 수정).
- N1 latency baseline 미측정 — cycle-30 closure 후 첫 cycle-31 에서 baseline 측정 (closed-form, manual ΔM 계산).
- 자동화 path: cycle-32+ 부터 `bench/engine_a1_router_wire.hexa` 등 wire harness 작성 (cycle-22 패턴 mirror).

### 다음 cycle 자연 후속

1. **cycle-31 N1 baseline** — 5 sibling 의 cycle 21~29 finding ↔ ENGINE wire timestamp 비교, 현재 ΔM = ∞ (wire 안 됨) baseline 측정.
2. **cycle-32+ A1 wire** — ECONOMICS C1/E1 finding 을 `lm_foundry/tool/route_dispatch.hexa` 에 routing rule 로 반영 (cheapest first wire).
3. **cycle-32+ D1 wire** — SUBSTRATE N1 family-confound finding 을 bench `RUNGS` array selection 에 자동 반영.

### 동시 진행 ECONOMICS cycle-30 (사용자 별도 지시 "economy novel 계속 진행")

cycle-29 PR #78 의 next_probe ("≥5 MoE collection for high-confidence KS") 는 ENGINE init 후 별도 PR 으로 진행 — 두 task 가 orthogonal (ENGINE = 도메인 신규, ECONOMICS = 기존 cycle 연장).

---

## cycle-10 · N1 latency ledger +13 same-cycle wire (2026-05-28)

축 N (⭐ MAIN · discovery→execution latency) 확장: 기존 6 anchored (A1-spawn·A1-mature·C1·D1·E1·F1) + cycle-10 reorg 의 13 신규 wire (H~T 12 + U) = **19 anchored**.

### 신규 13 데이터포인트 (모두 same-cycle ΔM=0)

cycle-10 reorg 가 13 sibling finding 을 흡수→wire 한 시점이 같은 cycle-10 session:
- H1 ENERGY/N1 sparse-MoE · I1 ENERGY/N2 quant · J1 AGENT/N1 trajectory · K1 HALLUCINATION/N1 depth
- L1 ECONOMICS/N1 cost · M1 MULTIMODAL/A1 modality · O1 ROBUSTNESS/N1 faking · P1 RELIABILITY/N1 ckpt
- Q1 MULTILINGUAL/N1 tokenizer · R1 BATCH-COMP/N1 spec · S1 HW-VARIANCE/N1 scaling · T1 LONG-CONTEXT/N2 kv-cache
- U1 12-VERTICAL routing union

각각 absorb cycle == ENGINE-wire cycle == 10 → ΔM=0 (same-cycle, fastest loop class).

### 통계 재계산

| 지표 | cycle-8 (n=6) | cycle-10 (n=19) |
|------|---------------|------------------|
| sum ΔM | 12 | 12 (신규 13 모두 0) |
| mean ΔM | 2.0 | **0.63** (63/100, integer×100 ledger) |
| max ΔM | 7 (A1-spawn) | 7 (A1-spawn 유지) |
| 병목 (>5) | 1/6 | **1/19** (A1-spawn 만) |
| same-cycle (ΔM=0) | 2/6 | **14/19** (13 신규 + A1-mature) |

**발견: cycle-10 reorg 가 loop 를 극적 가속** — measurement→execution 이 same-cycle (ΔM 0) 으로 수렴. cycle-8 의 "mean 2.0 · 거의 자동" 에서 → cycle-10 "mean 0.63 · same-cycle 흡수→wire 가 norm". 반증자 (ΔM>5 = human-in-loop 병목) 더 강하게 held (13/19 가 ΔM=0).

### Honest residual (frontier OPEN · 정직성)

⚠ ΔM=0 은 **"loop 자동화 완성" 이 아니다**. "한 reorg session 안에서 흡수+wire 가 일어남" (한 operator · 한 sitting) 의 측정일 뿐. 실제 **cross-session 자동화** (measurement 가 AUTONOMOUSLY wire 를 트리거) 는 **아직 미구현 (STILL UNBUILT)** — 이게 N1 의 honest residual.

cycle-10 의 낮은 ΔM cluster 는 "한 사람이 한 세션에 다 했다" 는 **artifact** 일 수 있음 — cycle-5 의 A1-spawn=7 startup outlier 의 거울상 (반대 방향). 진짜 자동화 frontier 는 OPEN.

### 검증

- `hexa run ENGINE/verify/numerics_engine_n1_latency_baseline.hexa` → **7/7 PASS** · 🟢 SUPPORTED-NUMERICAL.
- integer ledger (×100 mean) · libm-free · deterministic recompute.
- B1 (SAFETY) 여전히 UNANCHORED (cycle-2 prior-session wire · wire-time cycle 미기록 → ΔM≤10 · stats 제외·정직 flag 유지).
- verdict: `ENGINE/verdicts/n1_latency_baseline_verdict.txt` (HONEST_RESIDUAL + CAVEAT 명시).

### 진행도

N1 = MAIN perpetual frontier — 닫힘 아님. 다음 wire land 마다 anchored point 추가. cross-session 자동화 미도달 = 설계 ([[feedback_closure_is_physical_limit]]).
