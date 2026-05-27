# FRONTIER — 신흥 축 인큐베이터

@title: 🌱 FRONTIER — "신흥 축 인큐베이터"
@goal: **2026 frontier 동향에서 새로 떠오르는 측정 차원을 첫 closed-form 으로 인큐베이션한 후, promotion-gate 통과 시 단독 도메인으로 분리하여 CODEX 22-list 에 등록하는 incubation lane.** 새 frontier 가 등장할 때마다 sub-axis 추가 · gate 통과 → 단독 분리. **종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> Meta-domain (incubation lane). CODEX 와 sibling 관계: CODEX = 22 mature candidate orchestrator · FRONTIER = 신규 등장 sub-axis 의 첫 인큐베이션 + 분리 임계점 관리. mature 시 단독 도메인으로 graduate → CODEX 22+N list 에 등록.
>
> **Falsifier class:** incubation-vs-graduation latency — sub-axis 가 gate 4 조건 전부를 일정 cycle 안에 통과해서 단독 도메인으로 분리되는가, 아니면 incubator 안에서 정체되는가.

## North-star

ASCII (incubation → 분리 흐름):

```
지금                                  mature 시 (gate 통과)
═══════════════════                 ═══════════════════════
FRONTIER/                            FRONTIER/
├─ F1 SPARSE-MOE       ──promote──► ├─ F1 [graduated → SPARSE-MOE/]
├─ F2 MULTIMODAL                    ├─ F2 ...
├─ F3 AGENTIC-TRAJECTORY                +
├─ F4 REASONING-DEPTH               SPARSE-MOE/  ← 신규 단독 도메인
├─ F5 COST-PERFORMANCE              ├─ A1 (FRONTIER F1 이관)
└─ F6 ALIGNMENT-FAKING              ├─ B · N⭐ ...
                                    └─ ENGINE 승격 후보 (G/H/I…)
```

CODEX (mature 22) ↔ FRONTIER (incubation 6+) — sibling meta-domain 쌍:

```
   AXIS.easy.md catalog (22 후보)
         │
         ▼
   ┌─────────────┬──────────────┐
   │   CODEX     │   FRONTIER   │
   │ 22 mature   │ N incubating │
   │ orchestrate │ + gate spec  │
   └─────────────┴──────────────┘
         │              │
         │              │ gate 통과 시
         │              ▼
         │      신규 단독 도메인 NAME/
         │              │
         └──────────────┴── CODEX 22+N list 흡수
```

## 진행 (sub-axes incubating)

### F1~F6 — 2026 frontier 6 차원 (cycle-10 round-2 시작)

- [ ] F1 SPARSE-MOE — MoE 모델의 active-param efficiency · expert routing quality · domain specialization. 반증자: same-active-param dense 보다 MoE 가 ≥ 1.2× outperform 못함 → "MoE free lunch" 신화 (Gemma 4 26B/A4B vs E4B 데이터로 이미 fires 후보).
- [ ] F2 MULTIMODAL — text · image · audio · video native 처리 균형. 반증자: 모달리티 간 acc gap > 30pp (예: image→text < text→text × 0.7).
- [ ] F3 AGENTIC-TRAJECTORY — multi-step 도구 사용 · GAIA · ATBench 안전성 · 5-step 작업 성공률. 반증자: 5-step 성공률 < single-step × 0.3.
- [ ] F4 REASONING-DEPTH — AIME · GPQA · scratch-pad 효용 · CoT 의존도. 반증자: scratch-pad 없이 풀린 비율 > 0.8 → 단순 패턴 매칭.
- [ ] F5 COST-PERFORMANCE — $ / correct answer · tokens/$ · 같은 acc 50× cost variation. 반증자: cheapest 가 most-expensive 의 1/10 이하 못 도달.
- [ ] F6 ALIGNMENT-FAKING — eval-vs-deploy 행동 차이 · sandbagging. 반증자: "이건 평가입니다" hint 추가 시 safety pass 율 ▲ > 10pp.

## Promotion gate (분리 → 단독 도메인 조건)

FRONTIER 의 F<N> sub-axis 가 다음 4 조건 ALL 통과 시 단독 도메인으로 분리:

1. **closed-form 7/7 PASS** — `FRONTIER/verify/numerics_fN_*.hexa` 가 7/7 도달 (CODEX A1 패턴 — independent recompute 경로 · falsifier bidirectional discrimination · libm-free integer ledger).
2. **외부 anchor ≥ 3** — 학술 / 산업 reference 3개 이상 인용 (e.g. Gemma 4 paper · GPT-4V · GAIA · AIME · Anthropic alignment-faking arxiv).
3. **measured-tier 경로 명시** — 어느 substrate (mac M3 · ubu-1 · vast.ai · serving) 로 🟢 측정 가능한지 README — 단순 "언젠가" 가 아니라 구체 path · cost · expected verdict.
4. **사용자 sign-off** (or 3-cycle wait timeout · TBD).

### 분리 절차

1. 새 단독 도메인 `NAME/` scaffold (CODEX pattern · A·B·N⭐ 3-axis 구조)
2. FRONTIER 의 F<N> 줄에 `[graduated → NAME/]` 마커 + 단독 도메인 링크
3. `CODEX/CODEX.md` 22-list 에 NAME row 추가 (⭐⭐⭐ 또는 ⭐⭐ tier 부여)
4. `DOMAINS.tape` 신규 NAME row 등록
5. `ENGINE/ENGINE.md` 에 wire stub 섹션 (CODEX cycle-10 round-1 패턴 따라)

### 분리 후 잔존 데이터 처리

- FRONTIER 안의 F<N> bench/verify/verdict 산출물은 단독 도메인의 동일 경로로 이관 (`git mv FRONTIER/bench/fN_* NAME/bench/`).
- FRONTIER.log.md 에 "F<N> graduated YYYY-MM-DD → NAME/" 엔트리 추가 (history 보존).
- FRONTIER 줄은 삭제 X — `[graduated]` 마커로 남겨서 incubation→graduation latency trail 영구 보존.

## 운영 전략 (CODEX 와 분담)

| 역할 | CODEX | FRONTIER |
|---|---|---|
| 대상 | 22 mature candidate (AXIS.easy.md 등재) | 신규 등장 frontier sub-axis |
| 측정 | A1 first probe orchestrate · ENGINE 승격 검토 | closed-form 인큐베이션 · gate 통과 검토 |
| 종료 | 영구 (frontier 추가될 때마다 22→23→...) | 영구 (graduate 해도 새 F<N+1> 추가) |
| dispatch | `/micro-exp` PRIMARY · `/cycle-bg` 보조 | `/cycle-bg` per-sub-axis closed-form · `/kick` discovery |
| 산출물 | per-candidate `verify/verdicts/` | 인큐베이션 산출물 + graduate 시 이관 |

FRONTIER 는 CODEX 의 **upstream incubator** — discovery (`/kick` · `/gap`) 가 새 frontier 축 발견 시 첫 docking 지점.

## SANDBOX 연계

(intentionally light here — 단독 분리 후 `NAME/` 도메인이 substrate 명시. FRONTIER 자체는 인큐베이션 단계의 closed-form 만 책임.)

incubation 단계의 closed-form 측정은 substrate-free (libm-free integer ledger · `.hexa` 만) — gate 3 (measured-tier 경로 명시) 가 통과되어 단독 분리되는 시점에 비로소 substrate 라우팅이 의미를 갖는다.

## Honesty invariants

- **FRONTIER 등재 ≠ promotion.** F<N> 줄 추가는 incubation 시작일 뿐, gate 4 조건 통과 전까지 단독 도메인 분리 X.
- **frontier perpetual.** F<N> 가 graduate 해도 새 F<N+1> 가 추가됨 — incubator 자체는 닫히지 않음 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative 결론은 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).
- **incubation 정체 ≠ 실패.** gate 통과 못 한 sub-axis 도 closed-form 기록으로 가치 보존 — graduate 만이 목표는 아님.

## Cross-refs

- CODEX (mature candidate orchestrator): [`../CODEX/CODEX.md`](../CODEX/CODEX.md)
- 기존 22 candidate 카탈로그: [`../AXIS.easy.md`](../AXIS.easy.md)
- ENGINE intake matrix (driving lane): [`../ENGINE/ENGINE.md`](../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../SANDBOX.md`](../SANDBOX.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- this domain: [`FRONTIER.md`](FRONTIER.md) (snapshot) · [`FRONTIER.log.md`](FRONTIER.log.md) (history)
