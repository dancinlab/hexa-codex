"""
install.hexa runtime test — requires the hexa-lang VM (`hexa` on PATH, or
$HEXA_BIN, or ~/.hx/bin/hexa).
"""
from __future__ import annotations

import os
import shutil
import subprocess
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parents[1]

# Portable fallback hexa-lang VM path: $HEXA_BIN overrides, else ~/.hx/bin/hexa.
_HEXA_FALLBACK = Path(os.environ.get("HEXA_BIN", Path.home() / ".hx" / "bin" / "hexa"))


def _have_hexa() -> bool:
    return shutil.which("hexa") is not None or _HEXA_FALLBACK.exists()


@pytest.mark.hexa
def test_install_hexa_runs_clean():
    if not _have_hexa():
        pytest.skip("hexa-lang runtime not available")
    hexa_bin = shutil.which("hexa") or str(_HEXA_FALLBACK)
    env = os.environ.copy()
    env.update({
        "HX_PKG_DIR":     str(ROOT),
        "HX_HOOK_PHASE":  "both",
        "HX_BIN_DIR":     "/tmp/hx-bin-test",
    })
    rc = subprocess.run(
        [hexa_bin, "run", "install.hexa"],
        capture_output=True, text=True, cwd=str(ROOT), env=env,
    )
    assert rc.returncode == 0, (
        f"install.hexa exit {rc.returncode}\nstdout:\n{rc.stdout}\nstderr:\n{rc.stderr}"
    )
    assert "selftest PASS — 17/17 verb specs present" in rc.stdout
