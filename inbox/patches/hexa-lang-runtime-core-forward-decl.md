# inbox/patches — hexa-lang runtime_core.c clang forward-decl

**Status:** VERIFIED-RESOLVED (no action required upstream)
**Target repo:** hexa-lang
**Kind:** patch (retrospective note)
**Discovered by:** hexa-codex cycle-2 pareto lower-bound agent — commit `5bbb9ad` (`feat(verify): Pareto $/task lower bound — closed-form floor at 82.22%, canonical 2-tier within 0.44pp`)
**Date filed:** 2026-05-23
**Reproduction host:** macOS (Darwin 25.5.0), clang default toolchain

## One-line summary

`runtime_core.c` clang `-Werror=implicit-function-declaration` regression
introduced by hexa-lang `f8fcbe9e` (#469) was fixed upstream by `e705349f`
(#482). No new patch needed — recorded here to close the cross-project
audit trail from hexa-codex cycle-2.

## Problem (historical)

- File: `hexa-lang/self/runtime_core.c`
- Offending commit: `f8fcbe9e` — `fix(runtime): hexa_call0/1/2/3/4 throw on non-callable target (PROBE r12 #17) (#469)`
- That commit added `__hexa_call_non_fn_throw` which calls `hexa_throw(hexa_str(_buf))` before either symbol is forward-declared in the translation unit. Both functions are defined later in the same TU (`hexa_str` near line 1379, `hexa_throw` further down).
- Under modern clang on macOS the missing prototype tripped `-Werror=implicit-function-declaration`, blocking any downstream consumer (including the hexa-codex pareto verifier) from running `hexa.real run`.

## Upstream resolution

- Fix commit: `e705349f` — `fix(runtime): slice negative-index wrap (Python canonical) — PROBE r14-D (#482)`
- The PROBE r14-D commit folded in the 2-line unblock alongside its primary
  payload. The relevant hunk in `self/runtime_core.c` (lines 1158-1163):

  ```c
  // a mystery void result.  hexa_throw routes through try/catch.
  // PROBE r14-D unblock: forward-decl hexa_throw / hexa_str — both are
  // defined later in this TU (lines ~1374 / ~2003) and would otherwise hit
  // `-Werror=implicit-function-declaration` under modern clang.
  extern HexaVal hexa_str(const char* s);
  extern void hexa_throw(HexaVal err);
  ```

## Reproduction attempt (2026-05-23)

From the hexa-codex worktree, exercising the same verifier path the
cycle-2 agent flagged:

```
$ cd /Users/ghost/core/hexa-codex
$ ~/.hx/packages/hexa/hexa.real run verify/numerics_economics_pareto_floor.hexa
... 10/10 checks passed
__HEXA_CODEX_NUMERICS_ECONOMICS_PARETO_FLOOR__ PASS
```

No clang diagnostic surfaced. hexa-lang HEAD at the time of this filing
is `2ebdcfa7` (`feat(tool): port build_hexa_cli.sh → .hexa + Mac refuse-gate (#483)`), well past `e705349f`.

## Recommended follow-up (hexa-lang side)

None. The forward-decl is already in tree and survives current PROBE-r14
churn. If a future refactor moves `__hexa_call_non_fn_throw` or splits
`runtime_core.c`, preserve the two `extern` lines or migrate them into a
private header so the macOS clang gate stays green.

## Cross-references

- hexa-codex discovery commit: `5bbb9ad`
- hexa-lang regression commit: `f8fcbe9e` (#469)
- hexa-lang resolution commit: `e705349f` (#482)
- Verifier exercised: `verify/numerics_economics_pareto_floor.hexa`
