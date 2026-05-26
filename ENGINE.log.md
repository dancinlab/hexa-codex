# ENGINE — log

Append-only history sister of `ENGINE.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.


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
