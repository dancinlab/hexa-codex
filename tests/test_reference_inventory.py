"""
Tests for verify/reference_inventory.py — papers/ + formal/ absorption audit.
"""
from __future__ import annotations

import hashlib
import json
import re
import subprocess
import sys
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parents[1]
VERIFY = ROOT / "verify"


REFERENCE_FILES = [
    "consciousness/measurement-protocol.md",
    "consciousness/red-team-failure.md",
]


@pytest.mark.auto
@pytest.mark.parametrize("relpath", REFERENCE_FILES)
def test_reference_present(relpath):
    path = ROOT / relpath
    assert path.exists(), f"missing absorbed reference: {relpath}"


@pytest.mark.auto
@pytest.mark.parametrize("relpath", REFERENCE_FILES)
def test_reference_has_canonical_provenance(relpath):
    text = (ROOT / relpath).read_text(encoding="utf-8")[:1024]
    assert "@canonical" in text, f"{relpath}: no @canonical header"
    assert "canon@" in text, f"{relpath}: no canon@<sha> coord"
    assert re.search(r"@md5_at_extraction:\s*[0-9a-f]{32}", text), (
        f"{relpath}: no @md5_at_extraction header"
    )


@pytest.mark.auto
def test_reference_inventory_runs_clean():
    rc = subprocess.run(
        [sys.executable, str(VERIFY / "reference_inventory.py"), "--json"],
        capture_output=True, text=True, cwd=str(ROOT),
    )
    assert rc.returncode == 0, rc.stdout
    data = json.loads(rc.stdout)
    assert data["all_ok"] is True
    assert all(r["status"] == "OK" for r in data["rows"])


@pytest.mark.auto
def test_consciousness_deepdives_listed_in_papers_README():
    """measurement-protocol + red-team-failure are referenced in papers/README.md."""
    p = ROOT / "papers/README.md"
    text = p.read_text(encoding="utf-8")
    assert "measurement-protocol.md" in text
    assert "red-team-failure.md" in text


@pytest.mark.auto
def test_consciousness_deepdive_quality_markers():
    """Both consciousness deep-dives carry their grade-tracking markers
    (BT-19 reference + verdict)."""
    pp = ROOT / "consciousness/measurement-protocol.md"
    rt = ROOT / "consciousness/red-team-failure.md"
    pp_text = pp.read_text(encoding="utf-8")
    rt_text = rt.read_text(encoding="utf-8")
    assert "BT-19" in pp_text and "BT-19" in rt_text
    # red-team explicitly downgrades [7?] CONJECTURE → [5] MISS
    assert "MISS" in rt_text or "downgrade" in rt_text.lower()
