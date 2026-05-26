# ENGINE — log

Append-only history sister of `ENGINE.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.


## 2026-05-27 — cycle-1 ENGINE A1 first wire · ECONOMICS E1 → router rule · 🟢 5/5 PASS

ENGINE 도메인의 **첫 fire** (cycle-30 init 이후 5 sibling cycle 동안 0/6 axes unfired).
ECONOMICS E1 (MoE active-param scaling-law divergence) 가 cycle-34 에서 n=11 PARITY
4-batch sign preservation 으로 mature → 즉시 ENGINE A1 axis 로 wire.

### 산출물

- [x] `engine/wire_a1_econ_e1_router_rule.hexa` — 13-model registry (4 dense + 9 MoE,
  cycle-26 c1 envelope + cycle-34 e1 landings 통합) · `econ_e1_route(class_label)` 함수
  emits ranked model index list. 2 class lane:
  - `cost_sensitive_chat`: MoE 중 dev_factor > dense median (24.05) 인 small-active 만
    선택, active_B ascending sort (cheapest inference first)
  - `max_quality_research`: dense 만 선택, active_B descending sort (peak quality first)
- [x] `verify/numerics_engine_a1_wire_econ_e1.hexa` — paired falsifier (5 checks):
  - C1: cost top-1 = MoE & dev > dense_median ✅ (Granite-3-3B-A800M, dev=625)
  - C2: cost top-3 avg active < 5B ✅ (avg=1.3B)
  - C3: quality top-1 = dense large (active ≥ 70B) ✅ (Llama3.1-405B, active=405B)
  - C4: deterministic (re-call same output) ✅
  - C5: cost top-1 dev > 2× dense_median ✅ (625 > 48.1, 13× margin)
- [x] `.verdicts/engine/a1_wire_econ_e1_verdict.txt` — verbatim verdict log

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
- wire: [`engine/wire_a1_econ_e1_router_rule.hexa`](engine/wire_a1_econ_e1_router_rule.hexa)
- falsifier: [`verify/numerics_engine_a1_wire_econ_e1.hexa`](verify/numerics_engine_a1_wire_econ_e1.hexa)
- verdict: [`.verdicts/engine/a1_wire_econ_e1_verdict.txt`](.verdicts/engine/a1_wire_econ_e1_verdict.txt)
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
