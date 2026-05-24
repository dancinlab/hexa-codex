# OPS.log.md — ops verb group history

> History sibling of [`OPS.md`](OPS.md). Per the dancinlab root `.md`
> spec/history split. Repo-wide cycle history shared across all 4 groups
> lives in `CHANGELOG.md` + `.roadmap.hexa_codex` §A.3.

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
