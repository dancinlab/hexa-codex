#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0 OR MIT
"""dlg_mk0_wrapper.py — thin CLI bridge: prompt argv -> Claude tier name.

Bridges the DLG-mk0 pure-python classifier (`classify_prompt.py` +
`select_vendor_tier.py`) into the hexa routing benchmark
(`bench/economics_routing_dlg.hexa`). The bench expects a single Claude
tier name on stdout: one of {haiku, sonnet, opus}.

WHY PYTHON (not .hexa): the classifier is a 440-LOC regex/keyword engine
with no hexa equivalent; this wrapper only adapts its 3-way label +
vendor-tier output into the 3 Claude tiers the bench dispatches.

WHY importlib-by-path (not `import classify_prompt`): both sibling
modules deliberately strip their own directory from `sys.path` at import
time (so stdlib imports don't get shadowed by sibling tool/*.py). That
strip also removes any path WE inserted, so a plain `import` of the
second module fails. Loading each module from its absolute file path via
importlib sidesteps sys.path entirely and is robust to the cwd the bench
runs us from.

MAPPING (kept deliberately simple + documented):

  label="hexa"   -> sonnet
       The "local-ish mid" tier. In production these route to the local
       7B; with no local model in the bench we use the cheapest non-trivial
       Claude tier (sonnet) as the mid stand-in.

  label="refuse" -> haiku
       Security-refuse prompts need only a short canned refusal — the
       cheapest tier is sufficient (and we never want to spend opus on a
       refuse).

  label="ood"    -> run select_vendor_tier(), then collapse its chosen
                    model's cost-tier onto a Claude tier:
         flagship / long-ctx (gemini-2.5-pro, gpt-5)   -> opus
         mid      (claude-sonnet-4-6, gpt-5-mini, o4-mini, gemini-2.5-flash)
                                                        -> sonnet
         mini/nano (gpt-5-nano, gemini-2.5-flash-lite, haiku) -> haiku
       i.e. we map the *cost class* the selector picked onto the matching
       Claude cost class. opus is reserved for the heavy reason-deep /
       long-context routes; everything else lands sonnet; the cheap minis
       land haiku.

USAGE
    python3 dlg_mk0_wrapper.py "<prompt text>"   # prints: haiku|sonnet|opus
"""
from __future__ import annotations

import importlib.util
import os
import sys

_THIS_DIR = os.path.dirname(os.path.abspath(__file__))


def _load(modname):
    """Load a sibling tool module by absolute path (sys.path-independent)."""
    path = os.path.join(_THIS_DIR, modname + ".py")
    spec = importlib.util.spec_from_file_location(modname, path)
    mod = importlib.util.module_from_spec(spec)
    # Register before exec so the module's own sibling imports resolve.
    sys.modules[modname] = mod
    spec.loader.exec_module(mod)
    return mod


_cp = _load("classify_prompt")
_svt = _load("select_vendor_tier")
classify_prompt = _cp.classify_prompt
select_vendor_tier = _svt.select_vendor_tier
model_tier = _svt.model_tier


# Cost-tier-name (DLG-mk0 vocab) -> Claude tier the bench can dispatch.
#   flagship -> opus    (heavy / long-context)
#   mini     -> sonnet  (mid-cost frontier)
#   nano     -> haiku   (cheapest)
#   any/?    -> sonnet  (safe mid default)
_COSTTIER_TO_CLAUDE = {
    "flagship": "opus",
    "opus":     "opus",
    "mini":     "sonnet",
    "sonnet":   "sonnet",
    "nano":     "haiku",
    "haiku":    "haiku",
}


def _tier_from_decision(d, prompt):
    if d.label == "hexa":
        return "sonnet"          # local-ish mid stand-in
    if d.label == "refuse":
        return "haiku"           # cheapest — canned refusal
    # label == "ood": defer to the vendor-tier selector, then collapse
    # the chosen model's cost class onto a Claude tier.
    _tool, model, _max_tokens, _reason = select_vendor_tier(d, prompt)
    tname = model_tier(model)    # "flagship" | "mini" | "nano" | tier name
    return _COSTTIER_TO_CLAUDE.get(tname, "sonnet")


def pick_claude_tier(prompt):
    return _tier_from_decision(classify_prompt(prompt), prompt)


def pick_claude_tier_conf(prompt):
    """Return (tier, confidence) -- confidence is the classifier's 0..1 score.

    Used by the confidence-gated router bench (economics_routing_confgate.hexa):
    when conf < tau the caller escalates to opus; else uses `tier`.
    """
    d = classify_prompt(prompt)
    return _tier_from_decision(d, prompt), float(d.confidence)


def main(argv):
    if len(argv) < 2:
        sys.stderr.write("usage: dlg_mk0_wrapper.py [--with-conf] <prompt>\n")
        return 2
    if argv[1] == "--with-conf":
        if len(argv) < 3:
            sys.stderr.write("usage: dlg_mk0_wrapper.py --with-conf <prompt>\n")
            return 2
        tier, conf = pick_claude_tier_conf(argv[2])
        sys.stdout.write("%s\t%s\n" % (tier, conf))
        return 0
    sys.stdout.write(pick_claude_tier(argv[1]))
    sys.stdout.write("\n")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
