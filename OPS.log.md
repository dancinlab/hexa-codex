> 📍 SSOT: [ARCHITECTURE.md](ARCHITECTURE.md) · governance [CLAUDE.md](CLAUDE.md)

# OPS.log.md — ops verb group history

> History sibling of [`OPS.md`](OPS.md). Per the dancinlab root `.md`
> spec/history split. Repo-wide cycle history shared across all 4 groups
> lives in `CHANGELOG.md` + `.roadmap.hexa_codex` §A.3.

---

## 2026-05-27 — cycle-28 · NOVEL 축 N1 spawned — heterogeneous-μ multi-node Erlang-C divergence (⭐ MAIN priority lane)

cycle-27 ECONOMICS 축 E (MoE-vs-dense distinct-family) 패턴을 OPS 로 미러링.
cycle-16 single-UMA M/M/c fit (μ_eff ∈ {9.53, 7.505, 5.0} req/s/slot,
ceiling=c·μ R²=1.0, `.verdicts/sandbox/m4_ops_formula_fit.txt`) 가 *homogeneous μ*
가정 위에 닫혔고 cycle-24 (PR #72) ubu-1 install 완료로 mini (M3 Metal UMA)
+ ubu-1 (x86 CPU-only Option A pre-built bin) 2-host 경로가 열렸다. 공개
이론 질문: classical M/M/c (homogeneous μ) 식이 heterogeneous μ_i (μ_mac/μ_ubu
~3.18x) 에서도 성립하는가, 아니면 별개 family (Bolch 2006 §6.3
heterogeneous-channel · Krishnamoorthy 1963 SED · Whitt 1986 dominated-slow)
인가?

**OPS.md §영구 축 N — NOVEL · MAIN priority lane (⭐).** N1 = heterogeneous-μ
aggregate Erlang-C 분리 측정. cycle-28 first-probe = closed-form recompute
(no substrate fire) — 3 routing variant 의 PREDICTED aggregate λ_max 도출.

- `.discoveries/ops-n1-heterogeneous-mmc.tape` — 3 @C seeds (homogeneous-extension
  · SED upper-bound · dominated-slow lower-bound). `hexa tape` lint 0 malformed.
- `verify/numerics_ops_n1_heterogeneous_mmc.hexa` — 5/5 PASS, tier 🟡
  SUPPORTED-BY-CITATION-AND-DERIVED. μ_mac=9.530 (cycle-16 c=1 MEASURED) +
  μ_ubu=3.000 (cycle-24 Option-A CPU-only Q4_K_M PREDICT) → 3-variant predict
  emit: homogeneous-additive 12.530 qps · SED steady 12.530 qps · dominated-slow
  6.000 qps. **Falsifier band [6.000, 14.409] qps** — cycle-29+ measured aggregate
  outside band → heterogeneous family extension needed.
- 외부 anchor: Bolch et al. 2006 *Queueing Networks and Markov Chains* (Wiley
  2nd ed.) §6.3 heterogeneous-channel M/M/c · Kleinrock 1975 *Queueing Systems
  Vol. I* (Wiley) §3.5 multi-server stability · Krishnamoorthy 1963
  *Operations Research* 11(2):321-330 (2-heterogeneous-server Poisson queue)
  · Whitt 1986 *Op. Res. Letters* 5(4):199-204 (single vs multi-server
  decision) · Larsen & Agrawala 1983 *IEEE TSE* SE-9(2):189-197.

**Verdict file:** `.verdicts/sandbox/n1_ops_heterogeneous_mmc_predict.txt`.

**Honest residual.** (1) μ_ubu=3.0 qps 는 PREDICT (Option-A CPU-only llama.cpp
upstream bench-based 추정), NOT measured — cycle-29+ fire 의 FIRST 셀이
mini c=1 + ubu-1 c=1 단독 baseline 을 찍어야 calibrate. (2) 3 routing-variant
predict 는 textbook classical 결과 — N1 의 NOVEL contribution 은 substrate 의
EMPIRICAL determination (어느 variant 에 가까운가, 또는 어느 것도 안 맞아
heterogeneous family 필요한가) 이고 cycle-29+ 에서 fire. (3) cycle-22 skeleton
의 `_dispatch_one` LB stub 는 round-robin 가정이지만 미구현 — cycle-29+
실측 fire 진입 전 LB policy 명시 select 필요. (4) tailscale :8090 timeout
residual 로 LAN 192.168.50.119 가 유일 live 경로 — predict 는 LAN RTT 가
μ^-1 (≈333ms for ubu-1) 대비 negligible 가정.

영구 axis 원리 ([[feedback_closure_is_physical_limit]]) 적용 — N1 은 cycle-29+
실측 fire 후에도 새 host topology (multi-rack · multi-DC) · 새 GPU class ·
새 serving stack (vLLM PagedAttention 분산) 등장 시 다시 열린다. 진행도 카운트
증가시키지 않음 (perpetual axis 설계).

---

## 2026-05-24 — cycle-15c · M2.OPS first SLO measurement RAN (substrate cross-domain)

The OPS group's first empirical SLO landing executed through the SANDBOX
substrate: `bench/sandbox_stage4_slo_under_load.hexa` (verdict
`.verdicts/sandbox/stage4_slo_under_load_summary.txt`). Qwen2.5-0.5B on
M3 Metal, 3 np × 3 rate offered-load grid, 6/9 cells valid.

**Headline OPS finding — latency saturation is an accuracy cliff.**
Under capacity (rate=5, ~56% util) p99=681ms at 88% accuracy; over
capacity (rate≥20) p99 explodes to 4434ms+ AND accuracy collapses to
19.75% — a fixed client timeout (`curl --max-time 30`) converts a
latency-SLO breach into a correctness-SLO breach. This is the M/M/c knee
the metered-API surface could never expose (no concurrency knob).
`best_np=1` for 0.5B on 16GB UMA — extra slots add KV-cache pressure
without raising the mem-bw-bound service rate (confirms cycle-6's np=4
ceiling from the opposite direction).

This is exactly the OPS axis the cross-link below predicted SANDBOX
would unblock. Honest residuals (2 boot-fail port-races, 1
over-saturation hang killed at ~30min) recorded in the verdict file +
`SANDBOX.log.md` cycle-15c entry. The F-CODEX-2 context-latency grid
(`context^τ`, a *different* axis) stays exec-PENDING.

## 2026-05-24 — SANDBOX server-mode unlocks OPS SLO measurement (substrate cross-link)

SANDBOX (per `SANDBOX.md` §Sibling domains) is now registered as the
shared empirical-contact substrate for the OPS group. OPS's declared
falsifier class in `OPS.md` — "SLO checks — deployment-tier recipes,
tool-use service-level objectives, eval-handoff schema conformance" —
cannot execute on the external `claude --bare -p` surface, which
hides the serving process and the scheduler. SLO measurement needs a
serving process *we own*.

Cycle-6 evidence (commit `24c8218`) that SANDBOX server-mode is the
substrate-side mechanism for OPS-style throughput / latency / batch
SLO work:

| candidate | verdict | numbers (verbatim from verdict file) |
|:---|:---|:---|
| `d_kv_prefix_share_persistent` | confirmed | `warm_server_with_prefix` vs `cold_cli` = **89.71%** wall reduction; `warm_server_with_prefix_total_wall_ms=10142`, `cold_cli_total_wall_ms=98594`, accuracy parity (17/20 ≥ 16/20) — `stage4_kvprefix_persistent_summary.txt` |
| `d_continuous_batching_server` | confirmed | `np4_speedup_vs_np1_pct=30.65`, `np4_batch_wall_ms=10068`, `np1_batch_wall_ms=14518`, `accuracy_preserved=true` — `stage4_continuous_batching_summary.txt`. **Honest:** cycle-1's 50%-discount target NOT reached (`beats_cycle1_batch_amortized_50pct=false`); `np8` 27.9% slower than np4 (UMA-saturated on 16GB) |

OPS gates that SANDBOX now unblocks (derived from OPS.md falsifier
class, not fabricated): p50/p99 latency SLO sweep at `-np ∈ {1,2,4,8}`
× Stage-2 N=2000 manifest · throughput frontier (tok/s) vs concurrency
· tool-use loop overhead · queue-depth backpressure · eval-handoff
schema conformance via the `--json-schema` substrate surface
(cycle-6 commit `b72567f` proved exposed).

The substrate-only-surface framing matches SAFETY's cross-link
(2026-05-24, commit `a233bff`) and ECONOMICS's cross-link (2026-05-24,
commit `8e8d1a2`). SANDBOX is the codex's `cx_empirical_contact` gate
made physical — one substrate, every domain's T4 claims.

## 2026-05-23 — domain doc opened

`OPS.md` / `OPS.log.md` created in the per-domain root-SSOT restructure
(alongside `SAFETY` / `ECONOMICS` / `SUBSTRATE`). The ops group itself is
unchanged — 4 verbs, spec-first, since v1.0.0.

## 2026-05-06 — v1.0.0 seed (Cycle 0)

4 ops verbs extracted unchanged from `canon@c0f1f570:domains/cognitive/`:
`deploy` · `enterprise` · `agent_serving` · `eval`. Part of the 17-verb /
4-group seed. Commit `63e8283`.

## v1.0.0 — per-verb SLO falsifiers preregistered

OPS owns no F-CODEX-1..4 arithmetic floor; each verb spec preregisters
its own SLO-check falsifier (latency / schema / handoff thresholds).
Empirical conformance PENDING — group focus lands at v1.3.0.

---

_Next: v1.3.0 (2026-12, PLANNED) — wire the ops verbs, ship the deploy +
agent-serving integration, land F-CODEX-2 empirical. Append round
entries here as the group progresses._
