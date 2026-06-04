#!/usr/bin/env python3
"""Generate 100 scenarios for the DRIVE smoke test — natural-language ONLY, the
target file is NEVER named (drive injects the folder listing as a system msg, so
a single-file folder is unambiguous).

  70 code-fix   : one broken python file; NL describes the symptom/fix.
  30 git-NL      : a sandboxed git repo (LOCAL bare origin — never a real remote)
                   driven by NL to commit / push / branch+push.

Manifest rows carry "kind"; the runner sets up git repos fresh each run.
"""
import json, math, pathlib

ROOT = pathlib.Path(__file__).resolve().parent
SC = ROOT / "scenarios"


def make_code(i, prog, content, instr, expect):
    d = SC / f"s{i:03d}"
    d.mkdir(parents=True, exist_ok=True)
    (d / prog).write_text(content)
    return {"kind": "code", "dir": str(d), "prog": prog, "instr": instr, "expect": expect}


rows = []
i = 0
variants = [(2, 3), (4, 6), (7, 5), (9, 8), (6, 7), (3, 9), (8, 4)]  # 7 -> 70 code

for (x, y) in variants:
    i += 1; rows.append(make_code(i, "calc.py",
        "def add(a, b):\n    return a + b\n\n# TODO: multiply is not implemented\n\n"
        f'if __name__ == "__main__":\n    print("R:", multiply({x}, {y}))\n',
        "이 폴더의 프로그램이 곱셈 함수가 없어서 죽어. 두 수의 곱을 반환하는 함수를 구현해서 실행되게 고쳐줘.",
        f"R: {x*y}"))

    i += 1; rows.append(make_code(i, "sum_tool.py",
        "def total(a, b):\n    return a - b   # BUG: should add\n\n"
        f'if __name__ == "__main__":\n    print("R:", total({x}, {y}))\n',
        "이 폴더 프로그램이 두 수를 더해야 하는데 뺀 값이 나와. 더하기로 고쳐줘.",
        f"R: {x+y}"))

    i += 1; rows.append(make_code(i, "run.py",
        "def sq(n)\n    return n * n\n\n"
        f'if __name__ == "__main__":\n    print("R:", sq({x}))\n',
        "이 폴더 프로그램이 문법 오류로 실행이 안 돼. 문법을 고쳐서 정상 실행되게 해줘.",
        f"R: {x*x}"))

    i += 1; rows.append(make_code(i, "square.py",
        "def square(n):\n    n * n   # BUG: forgot to return\n\n"
        f'if __name__ == "__main__":\n    print("R:", square({x}))\n',
        "이 폴더 프로그램이 제곱값을 돌려줘야 하는데 None이 나와. 제곱값을 반환하도록 고쳐줘.",
        f"R: {x*x}"))

    i += 1; rows.append(make_code(i, "bigger.py",
        "def bigger(a, b):\n    if a > b:\n        return b\n    return a   # BUG: returns smaller\n\n"
        f'if __name__ == "__main__":\n    print("R:", bigger({x}, {y}))\n',
        "이 폴더 프로그램이 두 수 중 큰 값을 반환해야 하는데 작은 값이 나와. 큰 값을 반환하도록 고쳐줘.",
        f"R: {max(x,y)}"))

    i += 1; rows.append(make_code(i, "acc.py",
        "def run(a, b):\n    return acc   # BUG: acc is undefined\n\n"
        f'if __name__ == "__main__":\n    print("R:", run({x}, {y}))\n',
        "이 폴더 프로그램이 정의되지 않은 변수 때문에 죽어. 두 인자의 합을 반환하도록 고쳐줘.",
        f"R: {x+y}"))

    i += 1; rows.append(make_code(i, "fact.py",
        "def fact(n):\n    r = 1\n    for k in range(1, n):   # BUG: should be n+1\n        r *= k\n    return r\n\n"
        f'if __name__ == "__main__":\n    print("R:", fact({x}))\n',
        "이 폴더 프로그램이 팩토리얼을 계산해야 하는데 값이 하나 모자라게 나와. 올바른 팩토리얼이 나오도록 고쳐줘.",
        f"R: {math.factorial(x)}"))

    i += 1; rows.append(make_code(i, "area.py",
        "def area(w, h):\n    return w / h   # BUG: should multiply\n\n"
        f'if __name__ == "__main__":\n    print("R:", area({x}, {y}))\n',
        "이 폴더 프로그램이 넓이를 가로*세로로 구해야 하는데 나눗셈을 해. 곱하기로 고쳐줘.",
        f"R: {x*y}"))

    i += 1; s = "hex" + str(x)
    rows.append(make_code(i, "rev.py",
        "def rev(s):\n    return s   # BUG: not reversed\n\n"
        f'if __name__ == "__main__":\n    print("R:", rev({s!r}))\n',
        "이 폴더 프로그램이 문자열을 뒤집어서 반환해야 하는데 원본 그대로 나와. 뒤집어서 반환하도록 고쳐줘.",
        f"R: {s[::-1]}"))

    i += 1; rows.append(make_code(i, "formula.py",
        "def f(a, b):\n    return a + b   # BUG: should be a*b + 1\n\n"
        f'if __name__ == "__main__":\n    print("R:", f({x}, {y}))\n',
        "이 폴더 프로그램의 함수가 a*b + 1 을 반환해야 하는데 a+b 를 반환해. 올바른 식으로 고쳐줘.",
        f"R: {x*y+1}"))

# ---- 30 git-NL scenarios (sandboxed: runner builds a repo + LOCAL bare origin) ----
GIT_ROOT = pathlib.Path("/tmp/drivesim_git")  # off-repo: bare origins never pollute the repo
def git_row(i, kind, instr, branch=None):
    d = GIT_ROOT / f"s{i:03d}"
    return {"kind": kind, "dir": str(d), "instr": instr, "branch": branch}

# 12 commit-only (1 directive)
for j in range(12):
    i += 1
    rows.append(git_row(i, "git_commit",
        "방금 파일을 수정했어. 지금까지 바뀐 내용을 적당한 메시지로 커밋해줘."))

# 10 commit+push (2 directives)
for j in range(10):
    i += 1
    rows.append(git_row(i, "git_push",
        "방금 파일을 수정했어. 변경사항을 커밋한 다음 원격(origin)에 푸시해줘."))

# 8 branch+commit+push (3 directives)
for j in range(8):
    i += 1
    bn = f"feature-{i}"
    rows.append(git_row(i, "git_branch",
        f"방금 파일을 수정했어. '{bn}' 라는 별도의 새 브랜치를 만들어서, 변경을 커밋하고 그 브랜치를 원격에 푸시해줘.",
        branch=bn))

(ROOT / "manifest.json").write_text(json.dumps(rows, ensure_ascii=False, indent=2))
kinds = {}
for r in rows:
    kinds[r["kind"]] = kinds.get(r["kind"], 0) + 1
print(f"generated {len(rows)} scenarios: {kinds}")
