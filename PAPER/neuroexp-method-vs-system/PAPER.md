# neuroexp-method-vs-system — paper status

@title: 📄 Method-Transfer vs System-Comparison — bio↔LLM mapping taxonomy (7🔵 + 3🟢, 10 axes)
@goal: 10개 probe (7 closed-form 🔵 + 3 measured-on-model 🟢) 로 bio↔LLM 매핑이 '방법론 전이(method-transfer, 6 MATCH)' 로는 성립하고 '시스템 동형(system-comparison, 4 MISMATCH)' 으로는 분리됨을 보이는 monograph. 6+4 split 이 closed-form(4+3)·measured(2+1) 두 tier 에서 동일 (zero 예외).

- [x] draft v1 — main.tex 전 섹션 (abstract·intro·pipeline·method·verify·results·limits·repro·conclusion)
- [x] references ≥10 — 11 entries (Hebb1949 · Schlag2021 · Albantakis2023 · Voita2019 · Michel2019 · Olsson2022 · Elhage2021 · Mordvintsev2020 · BiPoo1998 · White1986 · Vaswani2017)
- [x] compile clean — main.pdf 7 pages (xelatex × 3 + bibtex · emoji 경고 non-fatal)
- [x] 10 verdict link — NEUROEXP/verdicts/{n1,phi1,l1,c1,l2,c2,s1,n2,phi2,s2}_*.txt
- [x] cycle-11~13 T4 실측 후 §results 🟠→🟢 graduation — L2·C2·S2 measured (Qwen2.5-1.5B) 반영 · 10 axes (7🔵+3🟢) · 6+4 split 두 tier 일관 · main.pdf 7 pages
- [ ] figures — 현재 table-only (fig 추가 선택적; 6+4 split bar 또는 method/system 2-col diagram 후보)
- [ ] arxiv submit ready (`/paper arxiv-prep .`) — 외부 제출 시 author block 확정 필요
- [ ] cycle-14+ scale sweep 후 measured tier 확장 (Qwen2.5-{0.5B,3B,7B}×layer)
