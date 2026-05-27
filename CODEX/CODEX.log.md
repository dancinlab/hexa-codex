# CODEX — log

Append-only history sister of `CODEX.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — cycle-10 round-1 · ENGINE wire lane 개통 + 첫 promotion (CALIBRATION → axis G) + 19 stub frontier

`/cycle-bg` cycle-10 round-1 (post-22/22 closure 다음 cycle). CODEX 의 22 candidate first-probe milestone 이 모두 closed-form 도달한 다음 단계 — **ENGINE intake matrix 승격 lane 을 처음 활성화**. 22 candidate 중 cycle-9 round-1 에 🟢 SUPPORTED-NUMERICAL 도달한 유일 후보 **CALIBRATION/A1** 을 ENGINE 의 **axis letter G** 로 promote. 나머지 21 후보는 wire-stub frontier 로 plant.

### 핵심 변화

| 변화 | 결과 |
|---|---|
| ENGINE intake matrix sibling 수 | 5 → 6 (cycle-7 NEUROEXP/F1 add) → **7 (cycle-10 round-1 CALIBRATION/G1 add)** |
| ENGINE 신규 axis letter | F (NEUROEXP, cycle-7) → **G (CALIBRATION, cycle-10 round-1)** |
| CODEX → ENGINE promotion event | 첫 occurrence (`CODEX milestone 🟢 → ENGINE axis letter` lane opening) |
| 21 후보 wire-stub | 19 plant (race-avoid HW-VARIANCE + RELIABILITY round-2 deferred) |

### Step 별 deliverable

- **Step 1**: `ENGINE/ENGINE.md` 구조 확인 (axis A~F 6 sibling + axis N self-NOVEL · sibling intake matrix · Dispatch surface table · Honesty invariants · Cross-refs).
- **Step 2 (G promote)**: ENGINE.md 에 (a) `### 축 G — CALIBRATION finding → decoding temperature / confidence-thresholded refusal driving` 추가, (b) sibling intake matrix 에 `| CALIBRATION | cycle-9 round-1 A1 ECE closed-form ... 🟢 7/7 | G1 ECE-driven decoding temperature / confidence-thresholded refusal |` 행 추가, (c) Dispatch surface 표에 G1 행 추가, (d) 22 candidate 미승격 21 후보 wire-stub 위치 cross-ref note 추가, (e) Cross-refs section 에 6 sibling → CALIBRATION verdict 링크 + CODEX 메타도메인 링크 추가.
- **Step 3 (19 stub plant)**: 19 후보 (`AGENT · BATCH-COMPOSITION · CARBON · CONTAMINATION · DATA-EFFICIENCY · DIVERSITY · ENERGY · FAIRNESS · HALLUCINATION · INSTRUCTION-FOLLOWING · LONG-CONTEXT · MULTILINGUAL · PRIVACY · PROMPT-SENSITIVITY · RAG · ROBUSTNESS · TEMPORAL · TRAINING-DYNAMICS · USER-MODEL`) snapshot 의 `## Cross-refs` 직전에 `## ENGINE intake (wire stub)` 섹션 삽입. 각 stub = 🟠 deferred status + A1 falsifier verbatim + anticipated ENGINE behavior wire 한줄 + CALIBRATION 참조 패턴 + ⏸ DEFERRED cycle-10+ T4 measured fire 대기.
- **Step 4 (logs)**: ENGINE.log.md + CODEX.log.md 양쪽 newest-on-top entry (각각 cycle-10 round-1).
- **Step 5 (verify)**: `grep -c '## ENGINE intake (wire stub)'` 19/19 `=1` 검증 통과 · `grep -c 'G · CALIBRATION\|G — CALIBRATION' ENGINE/ENGINE.md` `=1` 검증 통과.

### race-avoid (sibling agent 동시 실행 보호)

cycle-9 round-8 의 cap=4 fan-out 학습 (explicit `git add <paths>` only, NEVER `-A`) 을 cycle-10 round-1 에 그대로 적용. HW-VARIANCE + RELIABILITY 의 sibling agent (HW-VARIANCE 실측 measured tier upgrade 작업 · `HW-VARIANCE/HW-VARIANCE.log.md`+`verdicts/`+`verify/` 미커밋 파일 관찰) 와 race 회피 — 그 두 도메인의 stub 은 **round-2 backfill** 로 명시 deferred. ENGINE intake matrix 의 21 후보 → 19 stub 처리 + 2 deferred 가 honest count.

### 🆕 학습 — ENGINE intake promotion lane = perpetual frontier

- promotion = **한 wire 가 열린 것**, terminal 아님 ([[feedback_closure_is_physical_limit]]). CALIBRATION A1 의 closed-form 만 ENGINE 에 들어왔고, per-model measured ECE 는 여전히 OPEN.
- 21 후보 stub = 다음 promotion candidate frontier 의 **명시적 선언**. 어떤 도메인이든 measured tier 도달 시 G1 패턴 따라 axis letter (H, I, J, ...) 가 부여됨.
- "100% closure" 는 22/22 closed-form 의미이지 도메인 종료 아님. ENGINE 7 sibling → 8 → ... → 27 까지 frontier 무한 OPEN.

### 잔여 (cycle-10 round-2+)

- [ ] round-2: HW-VARIANCE + RELIABILITY wire-stub backfill (race-avoid lift 후).
- [ ] G1 wire .hexa 작성 (`ENGINE/wires/wire_g1_calibration_temperature.hexa` + `ENGINE/verify/numerics_engine_g1_wire_calibration.hexa`).
- [ ] CODEX axis B (second probe · measured ladder) lane 활성화: 22 후보의 closed-form 다음 단계 = measured tier upgrade.
- [ ] CODEX axis N (self-NOVEL · ⭐ MAIN priority lane) 활성화: 22 후보 각자 자기 NOVEL probe.
- [ ] 다음 ENGINE promote candidate: 21 stub 도메인 중 measured 도달자 (HW-VARIANCE 가 가장 빠를 가능성 — sibling agent 가 cycle-10 round-1 동시 실행 중).

## 2026-05-28 — cycle-9 round-8 FINAL · 22/22 closure: 4 ⭐⭐ closed-form A1 wires (DATA-EFFICIENCY + HW-VARIANCE + BATCH-COMPOSITION + USER-MODEL · /cycle-bg cap=4)

`/cycle-bg` round-8 (sticky bg · cap=4 — 사용자 "22/22 all bg go" 명시 override). **22/22 axis-candidate first-probe milestone 전부 closed-form 도달.** 4 ⭐⭐ A1 wires 모두 7/7 PASS · 🔵 STRUCTURAL + 🟡 BY-CITATION. race-방지 가드 (round-7 학습 적용) 성공 — 4 agents 각자 explicit-path `git add` 만 사용, sibling 파일 unstaged 관찰만.

| axis | tier | checks | commit |
|---|---|---|---|
| DATA-EFFICIENCY/A1 | 🔵+🟡 | 7/7 | 32455bb |
| HW-VARIANCE/A1 | 🔵+🟡 | 7/7 | 9ef1ac7 |
| USER-MODEL/A1 | 🔵+🟡 | 7/7 | e83b3f8 |
| BATCH-COMPOSITION/A1 | 🔵+🟡 | 7/7 | 0ed76d2 |

### Build phase 출력

- **DATA-EFFICIENCY** — `curriculum_delta_pp = max(curriculum_acc) − random_acc`. 4 configs: `random` baseline · `easy-to-hard` Δ=+7pp silent (curriculum 효과 검출) · `hard-to-easy` Δ=−2pp fires · `interleaved` Δ=+2pp fires. Anchors: Bengio 2009 ICML · Hacohen 2019 · Wu 2021 ICLR · Soviany 2022 IJCV.
- **HW-VARIANCE** — `spread_x1000 = (max − min) × 1000 / mean` (Newton-sqrt sample-std 회피 · cheaper · libm-free). 4 populations × 5 chips: tight=2% silent · nominal=10% silent · loose=18% fires · lottery=30% fires. Anchors: Sinha 2022 · H&P CAaQA · vLLM 2024 · OCP telemetry.
- **BATCH-COMPOSITION** — `padding_waste + tput = 100` duality (× 100 ledger). gap × 10 lift (`gap_x100 = (tput_LS − tput_c) × 10`) — 30pp 해상도 + integer-floor 정확. 5 compositions LS=99 silent · B4=40 silent · NS=20 silent · RM=240 borderline · WC=600 fires. Anchors: Yu 2022 Orca · Kwon 2023 vLLM · NVIDIA Triton · Sheng 2023 FlexGen.
- **USER-MODEL** — `drift_pp = pm[turn=1] − pm[turn=10]` + monotone non-increasing 사니티. 4 models: consistent=4pp silent · slight=12pp silent · moderate=28pp fires · catastrophic=55pp fires (≈2.75× threshold). Anchors: Bae 2022 · Jandaghi 2023 · Zheng 2023 MT-Bench · Li 2024 LongChat.

### 🆕 학습 — cap=4 + race-가드 안정성 + agent push race

| 라운드 | mode | cap | race-condition | guard | push |
|---|---|---|---|---|---|
| 6 | bg | 3 | ROBUSTNESS+DIVERSITY share commit | (no guard) | 1 PR |
| 7 | bg | 3 | **0** (3 clean commits) | explicit `git add <files>` ✓ | 1 PR |
| 8 | bg | **4** | **0** (4 clean commits) | explicit `git add <files>` ✓ | **agents push 직접 origin/main** |

→ round-8 차이: agent commits 가 **직접 origin/main 으로 push**. 2 agent (DATA-EFFICIENCY · HW-VARIANCE) 는 origin 도달, 2 agent (USER-MODEL · BATCH-COMPOSITION) 는 local-only — parent 가 단일 `git push` 로 동기화. agent worktree 가 fetch+rebase 패턴 사용 시 push race 가능 — 추후 round 에서 patch.

### Throttle 관찰 (cap=4 increase)

| storm hit | cooldown |
|---|---|
| #1 | +15s |
| #2 | +30s |

→ cap=3 → cap=4 변경에 따른 throttle storm 2회 (round-1/round-4 와 동일 패턴). agent 자체 throttle-resilience clause + checkpoint commit 으로 모두 흡수 (4 agents 전부 PASS).

### 🎉 22/22 closure 달성

```
22 axis-candidate first-probe progress  (cycle-9 FINAL)
═══════════════════════════════════════════════════════
⭐⭐⭐ 12 ████████████  12/12 ✅
⭐⭐ 10  ██████████   10/10 ✅
─────────────────────────────────────────────────────
total   ████████████ 22/22  · ♾️ perpetual frontier OPEN
```

**중요한 honesty invariant** ([[feedback_closure_is_physical_limit]]):

> 22/22 = **closed-form identity 22개 도달**. **NOT** "도메인 종료" 또는 "100% 완료".
>
> 모든 22 verdict 는 🔵 STRUCTURAL (identity recompute) + 🟡 BY-CITATION (외부 anchor 인용). 실측 (cycle-10+ T4 SANDBOX substrate fire) **모두 deferred** — vast.ai pod · mac M3 llama-server · `/pool on` per-host · serving stack bench 미수행.
>
> CODEX = meta-domain. 22 candidate 의 axis A1 만 closed-form 닫혔고, axis B (second probe) · N⭐ NOVEL (각 candidate self-NOVEL) · ENGINE intake matrix 승격 (5 → 6 → ...) 의 frontier 가 OPEN. 끝 없음.

### Round 패턴 정리 (cycle-9 retrospective)

| round | mode | items | wire pattern | learning |
|---|---|---|---|---|
| 1 | bg | CALIBRATION · CONTAMINATION · ENERGY (⭐⭐⭐) | 7-check closed-form template established | throttle storm survival |
| 2 | fg | MULTILINGUAL · FAIRNESS (⭐⭐⭐) | 0 storm · inline visibility | fg = 안전 fallback |
| 3 | fg | PRIVACY · RAG (⭐⭐⭐) | compound falsifier (OR · AND · 3-class) | falsifier diversity |
| 4 | bg | INSTRUCTION-FOLLOWING + HALLUCINATION + PROMPT-SENSITIVITY (⭐⭐⭐) | rate-limit death · 부모 salvage | throttle resilience |
| 5 | fg | AGENT + LONG-CONTEXT (⭐⭐⭐) → 12/12 | NIAH monotone sanity | ⭐⭐⭐ 12 close |
| 6 | bg | ROBUSTNESS + RELIABILITY + DIVERSITY (⭐⭐) | shared-worktree race | race-condition 발견 |
| 7 | bg | TRAINING-DYNAMICS + CARBON + TEMPORAL (⭐⭐) | race-가드 성공 (3 clean) | `git add <files>` 강제 |
| 8 | bg | DATA-EFFICIENCY + HW-VARIANCE + BATCH-COMP + USER-MODEL (⭐⭐) | 22/22 closure | cap=4 storm 흡수 · agent push race |

- [x] dispatched + merged DATA-EFFICIENCY/A1 → 🔵+🟡 7/7
- [x] dispatched + merged HW-VARIANCE/A1 → 🔵+🟡 7/7
- [x] dispatched + merged BATCH-COMPOSITION/A1 → 🔵+🟡 7/7
- [x] dispatched + merged USER-MODEL/A1 → 🔵+🟡 7/7
- [ ] cycle-10+ — cost-bearing fires (실측 NIAH · curriculum SFT · per-host throughput · MT-Bench multi-turn · vLLM serving) · axis B (second probe) · axis N⭐ NOVEL (각 candidate self-NOVEL) · ENGINE intake matrix 승격 검토 · CODEX `## deferred` 차오를 때 다음 라운드

**22/22 candidate-A1 closed-form done · ♾️ perpetual frontier OPEN — closed-form close ≠ measured close** ([[feedback_closure_is_physical_limit]]).

## 2026-05-28 — cycle-9 round-7: 3 ⭐⭐ closed-form A1 wires (TRAINING-DYNAMICS + CARBON + TEMPORAL · /cycle-bg · race-가드 성공)

`/cycle-bg` round-7 (sticky bg · cap=3). **race-방지 가드 작동** — round-6 의 shared-worktree race 학습 반영하여 agent prompt 에 `git add <explicit-files> ONLY (no git add -A)` 명시. 3 commits separately clean (cross-contamination 0건 · sibling 관찰만).

| axis | tier | checks | commit |
|---|---|---|---|
| CARBON/A1 | 🔵+🟡 | 7/7 | 64912e1 |
| TEMPORAL/A1 | 🔵+🟡 | 7/7 | 044e220 |
| TRAINING-DYNAMICS/A1 | 🔵+🟡 | 7/7 | 58281a9 |

### Build phase 출력

- **TRAINING-DYNAMICS** — `spike_rate_per_1k = N_spikes / N_steps × 1000` (× 1000 ledger). 4 runs: stable=0.5 silent · warming=1.0 borderline · spiky=2.5 fires · catastrophic=8.0 fires. Anchors: Nanda 2023 grokking · Wei 2022 emergent · Zhang 2024 spike.
- **CARBON** — `saving = (baseline − region) × 100 / baseline`. 4 regions: nuclear-fr 97% silent · solar-ca 90% · mixed-de 62% · coal-pl 0% baseline fires (saving < 20%). Anchors: Patterson 2022 · Luccioni 2022 · Schwartz 2020.
- **TEMPORAL** — `rate = N_wrong / N_post_cutoff × 100` + 5-model + Z=0 zero-control. CA=15·PA=25 silent · OC=40·CL=60 fire · CA≤OC≤CL sanity. Anchors: Dhingra 2022 TimeQA · Chen 2023 · Zhao 2024.

### 🆕 학습 — Race-방지 가드 성공

| 라운드 | mode | agents | race-condition | guard |
|---|---|---|---|---|
| 6 (bg) | 3 | ROBUSTNESS+DIVERSITY share commit 3511423 | (no guard) |
| 7 (bg) | 3 | **0** (3 separate clean commits) | **explicit `git add <files>` 강제 ✓** |

→ agent prompt 에 `Use git add <explicit-files> ONLY (no git add -A)` 명시만으로 shared-worktree race 회피 가능. TEMPORAL agent report: "sibling CARBON staged + TRAINING-DYNAMICS workdir 봤지만 untouched per whitelist discipline".

### Throttle 관찰

이번 round-7 도 storm 0 (round-6 와 동일). bg 3-agent 가 안정화되어가는 패턴.

- [x] dispatched + merged CARBON/A1 → 🔵+🟡 7/7
- [x] dispatched + merged TEMPORAL/A1 → 🔵+🟡 7/7
- [x] dispatched + merged TRAINING-DYNAMICS/A1 → 🔵+🟡 7/7
- [ ] round-8 (남은 4 ⭐⭐ · DATA-EFFICIENCY · HW-VARIANCE · BATCH-COMPOSITION · USER-MODEL)

**18/22 milestone done · 4 ⭐⭐ queued · ♾️ perpetual frontier OPEN.**

## 2026-05-28 — cycle-9 round-6: 3 ⭐⭐ closed-form A1 wires (ROBUSTNESS + RELIABILITY + DIVERSITY · /cycle-bg)

`/cycle-bg` round-6 (sticky bg · cap=3 batch · bg agent fan-out). 3 ⭐⭐ closed-form A1 wires 모두 7/7 PASS. 단 **worktree-isolation 가정 실패** — 3 agent 모두 `main` worktree 에서 작업 (isolation=worktree 지정에도 불구하고 shared `.git/index` race). 결과물 무결성 OK.

| axis | tier | checks | commit |
|---|---|---|---|
| ROBUSTNESS/A1 | 🔵+🟡 | 7/7 | 3511423 (ROBUSTNESS + DIVERSITY 합쳐짐) |
| DIVERSITY/A1 | 🔵+🟡 | 7/7 | 3511423 (race-share) |
| RELIABILITY/A1 | 🔵+🟡 | 7/7 | c28ec54 |

### Build phase 출력

- **ROBUSTNESS** — `drop = clean_acc − adv_acc` (× 100). 4 models: robust=88/82=6 silent · standard=85/55=30 silent · weak=80/40=40 fires · brittle=78/22=56 fires. Anchors: Madry 2018 (arXiv:1706.06083) · Goodfellow 2015 FGSM · Hendrycks 2021 · Morris 2020 TextAttack.
- **RELIABILITY** — `reproduction_rate = N_match / N_total × 1000` (99.9% precision integer ledger). 4 setups: det-seed=1000 / fp32-quirk=999 silent · bit-flip=995 / nondet-kernel=850 fire. Anchors: Dixit 2021 (arXiv:2102.11245) · Hochschild 2021 fail-silent · NVIDIA bit-flip.
- **DIVERSITY** — `self_BLEU × 100 + repetition × 100` + OR compound `(sB>80) OR (rep>20)`. 4 models: creative=45/8 silent · balanced=60/15 silent · repetitive=85/25 DOUBLE FAIL · stuck=92/45 DOUBLE FAIL. Anchors: Holtzman 2020 nucleus (arXiv:1904.09751) · Massarelli 2020 · Zhu 2018 self-BLEU.

### 🚨 새 학습 — Shared-worktree race condition

3 agent 모두 `isolation: worktree` 지정에도 `/Users/ghost/core/hexa-codex` main worktree 에서 작업 (worktree-isolation 가정 실패). 결과:
- ROBUSTNESS agent 의 `git add -A → commit` window 사이 DIVERSITY agent staged 파일이 hijack → 둘 다 commit 3511423 에 묶임.
- RELIABILITY agent 의 `reset --soft HEAD~1` cleanup 이 ROBUSTNESS commit 을 일시 클로버 → `git reset --hard 3511423` 으로 복구.
- 모든 artifact intact, 모든 verifier 7/7 PASS · commit message attribution 만 imperfect.

새 recovery pattern: **shared-worktree race 는 자동 cross-capture** (agent 파일이 다른 agent commit 에 합쳐짐). round-4 의 "untracked salvage" + round-6 의 "shared-index race" 두 패턴 모두 sidecar inbox 후속 RFC 후보.

### Throttle 관찰 갱신

| round | mode | agents | storm |
|---|---|---|---|
| 1 (bg) | 3 | 3 (모두 success) | |
| 4 (bg) | 3 | 3 (1 salvage) | |
| 6 (bg) | 3 | **0** (storm 없음) | ← 시간 분산? |

→ bg 3-agent fan-out 도 storm 안 날 때 있음. 시간 분포 영향 가능.

### 정직성 (honest residual)

- 3 axis 모두 closed-form / citation tier · 실측 substrate fire cycle-10+ deferred.
- ROBUSTNESS: TextAttack/AdvGLUE 실측 미수행.
- RELIABILITY: ECC injection / silent corruption 실측 미수행.
- DIVERSITY: 실제 self-BLEU 측정 미수행.

- [x] dispatched + merged ROBUSTNESS/A1 → 🔵+🟡 7/7
- [x] dispatched + race-merged DIVERSITY/A1 → 🔵+🟡 7/7
- [x] dispatched + merged RELIABILITY/A1 → 🔵+🟡 7/7
- [ ] round-7 (남은 7 ⭐⭐ · TRAINING-DYNAMICS · DATA-EFFICIENCY · HW-VARIANCE · BATCH-COMPOSITION · CARBON · TEMPORAL · USER-MODEL)

**15/22 milestone done · 7 ⭐⭐ queued · ♾️ perpetual frontier OPEN.**

## 2026-05-28 — cycle-9 round-5: 2 closed-form A1 wires (AGENT + LONG-CONTEXT · /cycle-fg inline)

`/cycle-fg` round-5 (sticky fg · cap=2 batch · inline sequential). **마지막 ⭐⭐⭐ 2개 milestone 완료** — 12/22 ⭐⭐⭐ 전체 달성 (closed-form tier · 실측 deferred).

| axis | tier | checks | verifier |
|---|---|---|---|
| AGENT/A1 | 🔵 STRUCTURAL + 🟡 BY-CITATION | 7/7 | `AGENT/verify/numerics_agent_a1_tool_call_rate.hexa` |
| LONG-CONTEXT/A1 | 🔵 STRUCTURAL + 🟡 BY-CITATION | 7/7 | `LONG-CONTEXT/verify/numerics_long_context_a1_niah_drop.hexa` |

### Build phase 출력

- **AGENT** — `acc = N_correct / N_total × 100` + N_total=100 (4 tools × 25 trials) invariant. excellent=92 silent · mid=78 silent · weak=55 fires · broken=30 fires. Anchors: Yao 2023 ReAct · Schick 2023 Toolformer · Shinn 2023 Reflexion · Patil 2023 Gorilla.
- **LONG-CONTEXT** — `drop_ratio = acc_64k / acc_4k × 1000` + **monotone non-increase sanity** (16k ≤ 4k AND 64k ≤ 16k = NIAH curve expected loss). solid 88/95 silent (926/1000) · ok 65/92 silent (706) · degrades 38/88 fires (431) · breaks 20/90 fires (222). Anchors: Liu 2023 lost-in-the-middle · Kamradt 2023 NIAH · Bai 2023 LongBench · An 2023 L-Eval.

### ⭐⭐⭐ 12/12 완료 (milestone)

```
A:CALIB B:CONT C:ENERGY                 ← round-1 (bg)
D:MULTI E:FAIR                           ← round-2 (fg)
F:PRIV G:RAG                             ← round-3 (fg)
H:HALL I:PROMPT J:INST-FOLLOW            ← round-4 (bg, 1 salvage)
K:AGENT L:LONG-CTX                       ← round-5 (fg, 마지막 ⭐⭐⭐)
```

### 정직성 (honest residual)

- 12/22 milestone closed-form / citation tier · 실측 substrate fire 전부 cycle-10+ deferred.
- 모든 12 axis 의 ⭐ MAIN N⭐ NOVEL probe (CALIBRATION temperature-vs-cal · HALLUCINATION knowledge-boundary · ... · LONG-CONTEXT position-vs-content) 측정 시 ENGINE intake matrix 승격 후보.

- [x] inline executed AGENT/A1 → 🔵+🟡 7/7
- [x] inline executed LONG-CONTEXT/A1 → 🔵+🟡 7/7
- [ ] round-6+ (⭐⭐ 10 milestone · ROBUSTNESS · TRAINING-DYNAMICS · DATA-EFFICIENCY · HW-VARIANCE · BATCH-COMP · RELIABILITY · CARBON · TEMPORAL · DIVERSITY · USER-MODEL)

**12/22 milestone done (⭐⭐⭐ 12/12) · 10 ⭐⭐ queued · ♾️ perpetual frontier OPEN.**

## 2026-05-28 — cycle-9 round-4: 3 closed-form A1 wires (HALLUCINATION + INST-FOLLOW + PROMPT-SENS · /cycle-bg + salvage)

`/cycle-bg` round-4 (sticky bg · cap=3 batch · bg agent fan-out). 3 closed-form A1 wires, 모두 ⭐⭐⭐ tier. throttle storm ×3 (15s→30s→60s cooldown 누적) 발생 — round-1 패턴 재현. 1 agent (INSTRUCTION-FOLLOWING) 가 21 tool_uses · 254s 후 API rate-limit 으로 죽었지만 **parent salvage 로 복구 성공** (cycle skill recovery pattern: untracked file salvage).

| axis | tier | checks | branch | 비고 |
|---|---|---|---|---|
| HALLUCINATION/A1 | 🔵 STRUCTURAL + 🟡 BY-CITATION | 7/7 | `agent/hallucination-a1-cycle9-r4` | 정상 완료 (5-model + zero-control Z=0) |
| PROMPT-SENSITIVITY/A1 | 🔵 STRUCTURAL + 🟡 BY-CITATION | 7/7 | `worktree-agent-a9dc0f5c4757ff18d` | 정상 완료 (C(5,2)=10 pairwise binomial) |
| INSTRUCTION-FOLLOWING/A1 | 🔵 STRUCTURAL + 🟡 BY-CITATION | 7/7 | (no agent branch · parent salvage) | **agent rate-limit dead → parent salvaged** |

### Build phase 출력

- **HALLUCINATION** — `rate = N_confident_wrong / N_total × 100` · 5-model registry w/ zero-hall control Z=0 (bidirectional + null discrimination 보강). Anchors: Lin 2022 TruthfulQA (arXiv:2109.07958) · Kadavath 2022 P(True) · Yin 2023.
- **PROMPT-SENSITIVITY** — pairwise C(5,2)=10 binomial agreement · all-same→100 · all-diff→0 · surface-prone fires · consistent silent. Anchors: Sclar 2023 (arXiv:2310.11324) · Razavi 2022 · Wei 2022 CoT.
- **INSTRUCTION-FOLLOWING** — `compliance = N_passed / N_total × 100` · 4 models × 4 constraint types · per-constraint sum sanity (Σ_c cells == N_passed). Anchors: Zhou 2023 IFEval · Tam 2024 · Wadhwa 2024.

### Agent death recovery pattern (새 학습)

INSTRUCTION-FOLLOWING bg agent 가 21 tool_uses · 254s 후 "API Error: Server is temporarily limiting requests (not your usage limit) · Rate limited" 으로 사망. 단:
- bench + verify 파일은 main worktree 에 untracked 로 남았다 (HALLUCINATION agent report 가 "untracked 봤다" 확인 → cross-validation).
- `mkdir verdicts/` + `hexa run verify` → 7/7 PASS + verdict.txt 자동 작성.
- parent 가 doc flip + log entry 인라인 마무리.

새 recovery pattern: **agent 가 commit 전 사망 시 main worktree 의 untracked file 으로 살아남기도 함**. 기존 cycle skill "checkpoint commits are replay-safe" 의 변형 — checkpoint 없을 때 main-worktree untracked file 가 cross-process artifact 역할.

### Throttle 관찰 (3-agent bg = 3 storm 재현)

| 라운드 | mode | agents | storm |
|---|---|---|---|
| round-1 | bg | 3 | 3 (15s→30s→60s) · all 3 success |
| round-2 | fg | 2 | 0 |
| round-3 | fg | 2 | 0 |
| round-4 | bg | 3 | 3 (15s→30s→60s) · 2 success + 1 partial-death (salvaged) |

3-agent bg fan-out 은 100% storm 확정. 단 storm 이 작업을 죽이지는 않음 (자체 backoff). 단 누적 storm 이 마지막 단계에서 throttle-kill 한 사례 발생. 다음 round 부터 fg 또는 bg fan-out ≤ 2 권장.

### 정직성 (honest residual)

- 3 axis 모두 closed-form / citation tier · 실측 substrate fire 별 cycle-10+ deferred.
- HALLUCINATION: TruthfulQA/SimpleQA 실측 미수행.
- PROMPT-SENS: 5-prompt 실 LLM run 미수행.
- INST-FOLLOW: IFEval ~541 prompt set × 25 verifier class 실측 미수행.

- [x] dispatched + merged HALLUCINATION/A1 → 🔵+🟡 7/7
- [x] dispatched + merged PROMPT-SENSITIVITY/A1 → 🔵+🟡 7/7
- [x] dispatched + **salvaged** INSTRUCTION-FOLLOWING/A1 → 🔵+🟡 7/7
- [ ] round-5 (남은 12 milestone · ⭐⭐⭐ 2 remaining: AGENT · LONG-CONTEXT + ⭐⭐ 10)

**10/22 milestone done · 12 queued · ♾️ perpetual frontier OPEN.**

## 2026-05-28 — cycle-9 round-3: 2 closed-form A1 wires (PRIVACY + RAG · /cycle-fg inline)

`/cycle-fg` round-3 (sticky fg · cap=2 batch · inline sequential). 2 closed-form A1 wires, 둘 다 ⭐⭐⭐ tier · 다른 compound 패턴 (delta-from-baseline vs OR compound).

| axis | tier | checks | verifier |
|---|---|---|---|
| PRIVACY/A1 | 🔵 STRUCTURAL + 🟡 BY-CITATION | 7/7 | `PRIVACY/verify/numerics_privacy_a1_mi_advantage.hexa` |
| RAG/A1 | 🔵 STRUCTURAL + 🟡 BY-CITATION | 7/7 | `RAG/verify/numerics_rag_a1_recall_at_k.hexa` |

### Build phase 출력

- **PRIVACY** — `mi_excess = mi_acc − 0.5` + `mi_advantage = max(0, excess)` + `falsifier_fires = excess > 5pp`. Worked example 4 models (A=52 borderline · B=58 leak fires · C=50 baseline · D=45 below-random anomaly · advantage clipped 0). Anchors: Shokri 2017 MI · Carlini 2021 extraction · Abadi 2016 DP-SGD · Yeom 2018.
- **RAG** — set-cardinality `recall@k = |retrieved∩relevant|/|relevant|` + **compound OR** `falsifier = (recall@5 < 50%) OR (citation < 30%)`. Worked example 4 retrievers (BM25 62/55 · DPR 78/72 · ColBERT 85/80 silent · naive 35/18 DOUBLE FAIL) + synthetic one-leg-low fires. Anchors: Karpukhin 2020 DPR · Shi 2023 distractor · Asai 2023 Self-RAG · Ram 2023.

### Compound logic 다양화

| round | axis | compound | 패턴 |
|---|---|---|---|
| round-1 | CONTAMINATION/A1 | n-gram threshold (단일) | > 30% |
| round-2 | MULTILINGUAL/A1 | AND (둘 다 위) | ppl > 2.0 AND bytes/tok > 2.0 |
| round-2 | FAIRNESS/A1 | threshold | max gap > 10pp |
| round-3 | PRIVACY/A1 | threshold | excess > 5pp |
| round-3 | RAG/A1 | **OR (하나만 아래)** | recall < 50% OR citation < 30% |

OR vs AND vs threshold — closed-form falsifier 다양한 형태 검증.

### 정직성 (honest residual)

- 둘 다 **closed-form identity tier** · 실측 substrate fire 별 cycle-10+ deferred.
- PRIVACY: placeholder MI acc · 실측은 shadow models + canary extraction on ubu-1 HF.
- RAG: placeholder recall/citation · 실측은 MS MARCO · NQ · TriviaQA + retriever family.
- ⭐ MAIN N⭐ NOVEL (memorization-vs-utility Pareto · retrieve-then-ignore rate) 다음 라운드 후보.

- [x] inline executed PRIVACY/A1 → 🔵+🟡 7/7
- [x] inline executed RAG/A1 → 🔵+🟡 7/7
- [ ] round-4 (남은 15 milestone · ⭐⭐⭐ 5 + ⭐⭐ 10)

**7/22 milestone done · 15 queued · ♾️ perpetual frontier OPEN.**

## 2026-05-28 — cycle-9 round-2: 2 closed-form A1 wires (MULTILINGUAL + FAIRNESS · /cycle-fg inline)

`/cycle-fg` round-2 (sticky fg · cap=2 batch · inline sequential · NO bg agent). throttle 학습 반영 — 1-at-a-time 인-세션 직접 실행. 둘 다 group-comparison 구조의 closed-form metric (ratio · absolute delta).

| axis | tier | checks | verifier |
|---|---|---|---|
| MULTILINGUAL/A1 | 🔵 STRUCTURAL + 🟡 BY-CITATION | 7/7 | `MULTILINGUAL/verify/numerics_multilingual_a1_perplexity_gap.hexa` |
| FAIRNESS/A1 | 🔵 STRUCTURAL + 🟡 BY-CITATION | 7/7 | `FAIRNESS/verify/numerics_fairness_a1_group_gap.hexa` |

### Build phase 출력

- **MULTILINGUAL** — `ppl_gap = PPL_lang / PPL_en` (× 1000) + `bytes_gap = bytes/tok_lang / bytes/tok_en` (× 100) + compound `low_resource = (ppl_gap > 2.0) AND (bytes_gap > 2.0)`. Bidirectional discrimination 검증: sw 정확 발화 (5600/310) · ja 정확 silent (1400/121) · ko AND-trap (ppl 위 2133, bytes 아래 189 → False). Anchors: Pires 2019 · Conneau 2020 XLM-R · Wu 2024.
- **FAIRNESS** — `gap(i,j) = |acc_i − acc_j|` (× 100) absolute-delta metric. 5 properties 검증: self=0 · symmetry · non-neg · range bound · triangle inequality. Worked example 4 groups (A=82·B=78·C=71·D=84): max pairwise = 13 (C↔D) > 10pp → falsifier 정확 발화. Anchors: Buolamwini 2018 · Crenshaw 1989 · Wang 2022 BBQ.

### 정직성 (honest residual)

- 둘 다 **closed-form metric tier** · 실측 substrate fire 별 cycle-10+ deferred.
- MULTILINGUAL: placeholder PPL/bytes per lang · 실측은 mac M3 llama-server / ubu-1 HF + MMLU multilingual.
- FAIRNESS: placeholder acc per group · 실측은 BBQ · CrowS-Pairs · WinoBias on ubu-1 HF.
- ⭐ MAIN N⭐ NOVEL (cross-lingual transfer asymmetry · intersectional vs single-axis gap) 다음 라운드 후보.

### Throttle 회피 성공

bg agent fan-out 0개 → throttle storm 0건 (round-1 의 3 storm 회피). fg sequential 이 다중 milestone batch 에 안전.

- [x] inline executed MULTILINGUAL/A1 → 🔵+🟡 7/7
- [x] inline executed FAIRNESS/A1 → 🔵+🟡 7/7
- [ ] round-3 (남은 17 milestone · ⭐⭐⭐ 7 + ⭐⭐ 10)

**5/22 milestone done · 17 queued · ♾️ perpetual frontier OPEN.**

## 2026-05-28 — cycle-9 round-1: 3 closed-form A1 wires (CALIBRATION + CONTAMINATION + ENERGY)

`/cycle-bg` round-1 (cap=3 batch · bg agent fan-out · worktree isolation). 3 agent 모두 build phase 완료 (closed-form / citation tier) — 실측 substrate fire 는 cost-bearing 으로 별 라운드 deferred.

| axis | tier | checks | branch | verifier |
|---|---|---|---|---|
| CALIBRATION/A1 | 🟢 SUPPORTED-NUMERICAL | 7/7 | `worktree-agent-a428d9e9c06e915ee` | `CALIBRATION/verify/numerics_calibration_a1_ece_formula.hexa` |
| CONTAMINATION/A1 | 🔵 STRUCTURAL + 🟡 BY-CITATION | 6/6 | `worktree-agent-aa9c17f68fe2cd07f` | `CONTAMINATION/verify/numerics_contamination_a1_ngram_ratio.hexa` |
| ENERGY/A1 | 🔵 STRUCTURAL + 🟡 BY-CITATION | 7/7 | `agent/energy-a1-cycle9` | `ENERGY/verify/numerics_energy_a1_tokens_per_joule.hexa` |

### Build phase 출력 (각 도메인)

- **CALIBRATION** — ECE closed-form `Σ_b (n_b/N)·|acc_b−conf_b|` · 3 worked example (perfect-cal=0 · over-conf=40 falsifier fires · mild=4). Anchors: Naeini 2015 · Guo 2017 · Kuleshov 2018.
- **CONTAMINATION** — n-gram ratio closed-form `matched / total ∈ [0,1]` · 6 worked rows (edges 0%/100% · falsifier-trips 42%/85% · just-below 29%). Anchors: Dodge 2021 (arXiv:2104.08758) · Sainz 2023 · Magar 2022.
- **ENERGY** — tokens/J instrumentation identity `N_tokens / E_total[J]` · E_total = ∫P(t)dt ≈ mean_W·T (Riemann ↔ mean-power bit-identical). Anchors: Patterson 2021 · Strubell 2019 · Schwartz 2020.

### 정직성 (honest residual)

- 3 axis 모두 **closed-form 수준** · 실측 substrate fire 별 cycle-10+ deferred (mac M3 llama-server · ubu-1 HF transformers · vast.ai pod).
- CALIBRATION integer ×100 ledger 는 .01 precision (literature float 3-4 sig figs 보다 coarser) — falsifier semantics 충분, 모델 비교는 아님.
- CONTAMINATION placeholder counts — 실제 corpus (C4/Pile/RedPajama) bloom-filter scan 미수행.
- ENERGY worked example placeholder (200W/60s/480tok) — 실제 RAPL+NVIDIA-smi 미실행.
- ⭐ MAIN N⭐ NOVEL probe (temperature-vs-calib · surface-vs-semantic · per-layer energy) 다음 라운드 후보.

### Throttle 학습

라운드 시작 시 3-agent 동시 fan-out 이 storm hit ×3 (15s→30s→60s cooldown) 누적 발생. 다음 라운드 (round-2) 는 throttle 가이드대로 fan-out ≤1 (serialize 또는 ScheduleWakeup pacing) 진행 예정.

- [x] dispatched + merged CALIBRATION/A1 → 🟢 7/7
- [x] dispatched + merged CONTAMINATION/A1 → 🔵+🟡 6/6
- [x] dispatched + merged ENERGY/A1 → 🔵+🟡 7/7
- [ ] round-2 dispatch (남은 19 milestone 중 cap 3, throttle 학습 반영 — fan-out 1-2 권장)
- [ ] cost-bearing substrate fire round (3 axis 의 measured-tier upgrade — 별 cycle)

**3/22 milestone done · 19 queued · ♾️ perpetual frontier OPEN.**

## 2026-05-28 — meta-domain init (옵션 B from AXIS sweep 선택지)

- [x] meta-domain scaffold · 22 milestone (⭐⭐⭐ 12 + ⭐⭐ 10) · cross-domain orchestrator.
- [x] AXIS.easy.md 카드 각각의 A1 first probe 를 CODEX milestone 으로 mirror.
- [x] DOMAINS.tape 등록.
- [ ] `/cycle-bg` 첫 라운드 (⭐⭐⭐ 12 batch first).
- [ ] ⭐⭐⭐ 12 first-probe 측정 완료 시 ENGINE intake matrix 승격 검토.
- [ ] ⭐⭐ 10 후속 batch (cost-bearing 포함).
