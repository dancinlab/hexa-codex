#!/usr/bin/env python3
# fig01_cost_correct.py - grouped bar chart for the economics-routing-savings
# paper: per-strategy total cost (USD) on the left axis and correct/20 on
# the right axis, for the two strategies in the 20-task Claude CLI tier-
# routing benchmark.
#
# Data source (verbatim aggregates):
#   .verdicts/economics-routing-savings/baseline.tsv  -> sum(cost_usd)=0.299947, correct=19
#   .verdicts/economics-routing-savings/router.tsv    -> sum(cost_usd)=0.081914, correct=19
#
# Rerun from the paper root:
#   python3 figures/_scripts/fig01_cost_correct.py
import matplotlib.pyplot as plt
import numpy as np

# Hardcoded aggregates from .verdicts/economics-routing-savings/{baseline,router}.tsv
STRATEGIES = ["Baseline (always opus)", "Router (length heuristic)"]
COSTS_USD  = [0.299947, 0.081914]
CORRECT    = [19, 19]
N_TASKS    = 20

plt.rcParams.update({
    "font.family": "DejaVu Sans",
    "font.size":   10,
    "axes.spines.top":   False,
})

fig, ax_cost = plt.subplots(figsize=(6.4, 3.6))

x      = np.arange(len(STRATEGIES))
width  = 0.35

# Left axis: total cost (USD), primary color
color_cost = "#C62828"
bars_cost = ax_cost.bar(x - width / 2, COSTS_USD, width,
                        color=color_cost, edgecolor="black", linewidth=0.6,
                        label="Total cost (USD)")
ax_cost.set_ylabel("Total cost (USD)", color=color_cost, fontsize=11)
ax_cost.tick_params(axis="y", labelcolor=color_cost)
ax_cost.set_ylim(0, max(COSTS_USD) * 1.30)
ax_cost.set_xticks(x)
ax_cost.set_xticklabels(STRATEGIES)
ax_cost.grid(axis="y", linestyle=":", alpha=0.4)

for i, c in enumerate(COSTS_USD):
    ax_cost.text(i - width / 2, c + max(COSTS_USD) * 0.02,
                 f"${c:.4f}", ha="center", va="bottom",
                 fontsize=9, fontweight="bold", color=color_cost)

# Right axis (twinx): correctness, secondary color
color_correct = "#1565C0"
ax_correct = ax_cost.twinx()
ax_correct.spines["top"].set_visible(False)
bars_correct = ax_correct.bar(x + width / 2, CORRECT, width,
                              color=color_correct, edgecolor="black",
                              linewidth=0.6,
                              label=f"Correct / {N_TASKS}")
ax_correct.set_ylabel(f"Correct (out of {N_TASKS})",
                      color=color_correct, fontsize=11)
ax_correct.tick_params(axis="y", labelcolor=color_correct)
ax_correct.set_ylim(0, N_TASKS * 1.15)

for i, k in enumerate(CORRECT):
    ax_correct.text(i + width / 2, k + N_TASKS * 0.02,
                    f"{k}/{N_TASKS}", ha="center", va="bottom",
                    fontsize=9, fontweight="bold", color=color_correct)

ax_cost.set_title("Cost vs correctness - 20-task Claude CLI tier-routing benchmark",
                  fontsize=11, pad=10)

handles = [bars_cost, bars_correct]
labels  = [h.get_label() for h in handles]
ax_cost.legend(handles, labels, loc="upper center",
               bbox_to_anchor=(0.5, -0.15), ncol=2, frameon=False,
               fontsize=9)

plt.tight_layout()

out_pdf = __file__.rsplit("/", 2)[0] + "/fig01_cost_correct.pdf"
plt.savefig(out_pdf, format="pdf", bbox_inches="tight")
print(f"[fig01_cost_correct] wrote {out_pdf}")
