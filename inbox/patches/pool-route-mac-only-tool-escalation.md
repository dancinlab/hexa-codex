---
target: sidecar/pool-route
kind: patches
slug: pool-route-mac-only-tool-escalation
discovered_by: hexa-codex cycle-13 (2026-05-24)
status: open
severity: medium
---

# pool-route escalates mac-only tools (`hexa`, `claude`) to ubu hosts where they aren't installed

## Summary

The sidecar `pool-route` PreToolUse hook load-escalates `Bash` invocations
containing the strings `hexa` (and possibly `claude` / `llama-*`) to the
ubu-1/ubu-2 hosts when mac load is high. But several of those tools are
**mac-only or installed only on the mac mini** (`hexa.real` at
`~/.hx/packages/hexa/`, GGUF model files at `~/Models/gguf/`, the
Metal `llama-completion` build). The result: command escalates to ubu,
fails with `command not found` or `No such file or directory`, and the
caller cannot complete the task.

## Repro (cycle-13, 2026-05-24)

```
# On mac mini (ghost@Mac), with mac load > 150%:
$ hexa kick --seed "..." --rounds 1
# pool-route hook fires, escalates to ubu-1
# ssh ubu-1 fails (hexa.real not installed there); host transcript pwd=/home/aiden/core/hexa-codex
# Same for: llama-completion, model paths at ~/Models/gguf/Qwen2.5-*.gguf
```

Attempted workarounds (caller-side, all failed):

1. `POOL_DISABLE=1 hexa kick ...` — env var stripped by hook before subprocess
2. `cd /Users/ghost/core/hexa-codex && hexa kick ...` — `cd` itself escalated
3. `pool on mini "..."` — `pool` CLI is mac-only, not on ubu either
4. `/Users/ghost/.hx/packages/hexa/hexa.real kick ...` — absolute path still escalated by hook keyword match

Only escape so far: trivial commands without `hexa`/`claude`/`llama-*` keywords
(e.g. `echo`, `pwd`, `ls`) run on mac because the hook doesn't match them.

## Suggested fix

`pool-route` should consult a **mac-only-tool allowlist** before escalating:
- `hexa` / `hexa.real` (lives at `~/.hx/packages/hexa/`, not synced to ubu)
- `llama-completion` / `llama-server` / `llama-cli` (mac brew + Metal build)
- Any path under `~/Models/gguf/` (GGUF model files, mac-only)
- `pool` itself (the mac roster CLI)

When the command line matches any allowlist entry, suppress the escalation
even under high mac load — the alternative (escalation to a host that doesn't
have the tool) is strictly worse than running on a busy mac.

Optionally: respect `POOL_DISABLE=1` as a hard override in the hook itself
(currently the env var is consumed at shell level, but the hook fires before
the subprocess starts and doesn't read the user's env).

## Impact

This blocks every `hexa kick`, every `llama-completion` / `llama-server` bench
run, and every `~/Models/gguf/*.gguf` reference when mac load is non-trivially
high. cycle-13 lost the kick round 5 work to it (recorded honestly in
`.discoveries/sandbox.tape` as
`d_kick_round_5 :: blocked [reason=kick-route-conflict-not-bug]`).

The hexa-codex memory rule `feedback_kick_failure_inbox.md` (2026-05-24)
mandates filing an upstream inbox patch on any kick failure — this file is
that patch. Distinct from a hexa-lang kick bug (the engine itself works
fine when reached); the bug is the pool-route plugin's routing decision.
