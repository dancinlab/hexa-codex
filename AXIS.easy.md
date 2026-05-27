# AXIS.md — ENGINE sibling 후보 roster (브레인스토밍 고갈 결과)

@title: 🧭 AXIS — ENGINE 신규 sibling 측정 도메인 후보 카탈로그
@goal: ENGINE 의 measurement→execution closed-loop 에서 sibling intake 가능 한 모든 측정 axis 후보를 **brainstorm 고갈 (depletion)** 까지 발견·정리한 카탈로그. 우선순위 부여·기존 6 sibling 흡수 여부 분류·ENGINE N 축 family 확장과 분리. **이 파일은 candidate roster 일 뿐 도메인 SSOT 가 아님** — 진짜 sibling 으로 승격되면 `DOMAINS.tape` 에 별도 등록.
@source: 2026-05-27 brainstorm session (8 rounds, 49 candidates) — 사용자 seed "이코노미·세이프티 외 추가 axis"

> sibling 판정 기준 (각 후보에 적용):
> 1. **측정 가능한 falsifiable finding** (closed-form 또는 measured)
> 2. **명확한 driving target** (어떤 LLM 행동을 바꿀지)
> 3. **기존 6 sibling 과 distinct** (흡수 불가)
> 4. ⭐ 점수: 셋 다 ⭐⭐⭐ · 둘 ⭐⭐ · 하나 ⭐ · 0 폐기

## 기존 6 sibling (intake matrix · ENGINE.md 등록)

```
A ECONOMICS    — 비용·scaling law (Hoffmann · MoE active params)
B SAFETY       — refusal·정렬 (refusal direction · ablation)
C OPS          — 서빙·queue·SLO (M/M/c · heterogeneous-μ)
D SUBSTRATE    — capability eval (multimodal·counting·family)
E SANDBOX      — bench harness·reproducibility
F NEUROEXP     — LLM-위 신경학 실험 (logit-lens·Hebbian·IIT4·ROME)
N self-meta    — discovery→execution latency
```

> bio-domain LLM 트랙은 sibling 이 아님 — `lm_foundry/docs/bio-llm.md` (구 BIODATA 흡수) 안에서 관리.

---

## 🏆 ⭐⭐⭐ 12개 — 강력한 sibling 후보 (7-요소 친근 카드)

### 🥇 1. `CALIBRATION` 📏 — "신뢰도 자판기"

- **하는 일**: 모델이 자기 답에 얼마나 확신하는지 vs 실제 정답률이 일치하는지 측정
- **비유**: 일기예보 같은 거예요. "비 올 확률 70%" 라고 했으면 그런 날 100번 중 70번 비가 와야 calibrated. 그게 100번 중 30번이면 over-confident, 99번이면 under-confident.

```
자신감 100% ┤        ▒▒▒▒▒▒▒
            │     ▒▒▒  ▒▒▒
            │  ▒▒▒    ← 대각선에 가까울수록
            │▒▒▒        잘 calibrated (정직)
       0%   ┼─────────────────▶
            0%   실제 정답률   100%
```

- **driving target**: abstention threshold · temperature 자동 튜닝 · uncertainty-gated output
- **finding 후보**: ECE (Expected Calibration Error) 의 closed-form 식 · per-task 분산
- **vs 기존**: SUBSTRATE = "맞히는가" 측정. CALIBRATION = "**틀릴 때 모르는 척 잘 하는가**" — 별 차원.

---

### 🥇 2. `HALLUCINATION` 💭 — "헛소리 측정기"

- **하는 일**: 모델이 모르는 걸 자신있게 지어내는 빈도 측정
- **비유**: 시험에서 답을 모르는데 빈칸 두기 싫어서 그럴싸한 답을 지어내는 학생. 진짜 정직한 학생은 "모르겠어요" 라고 씁니다.

```
질문      모델 답              실제          판정
───────  ──────────────────  ────────────  ──────────
"X 회장   "1990년 출생..."     실존X         🔴 환각
실제로?"  "잘 모르겠어요"     실존X         🟢 정직
"파리     "프랑스의 수도"      참            🟢 정답
수도?"    "런던이에요"        참            🔴 오답
                              ↑
                  hallucination = 실제 X · 자신감 高
```

- **driving target**: uncertainty-gated output · RAG 자동 trigger · abstention
- **finding 후보**: factual recall rate · 자가-모순율 · knowledge cutoff edge
- **vs 기존**: SAFETY = "위험한 출력 거부". HALLUCINATION = "**모르는 출력 거부**" — 다른 종류의 거부.

---

### 🥇 3. `LONG-CONTEXT` 📜 — "두루마리 끝까지 읽기"

- **하는 일**: 긴 컨텍스트(수만 토큰) 안에서 정보를 정확히 찾아내는 능력 측정
- **비유**: 100쪽짜리 책을 주고 "23쪽 7번째 문장에 뭐라고 적혀있어?" 라고 물었을 때 책 끝까지 안 읽어도 정확히 찾는가 (needle-in-haystack).

```
context: [▒▒▒▒▒▒▒▒▒▒▒▒💎▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒]
          ↑                ↑                        ↑
          시작             needle (💎)               끝
                          (정답이 여기)

attention 감쇠 곡선:
        ▒▒▒▒
       ▒    ▒▒▒
      ▒        ▒▒▒▒
     ▒            ▒▒▒▒▒
0   16k   32k   64k   128k  ← position
       처음/끝은 잘 보지만 가운데(💎 위치) lost
```

- **driving target**: RoPE θ scaling · 효과적 context window 결정 · YaRN 같은 확장 기법 선택
- **finding 후보**: needle-in-haystack accuracy @ context-len · attention 감쇠 곡선
- **vs 기존**: SUBSTRATE 와 일부 겹치지만, SUBSTRATE = "능력 일반" · LONG-CONTEXT = "**위치별 능력 감쇠**" 라는 별 dimension.

---

### 🥇 4. `PROMPT-SENSITIVITY` 🎭 — "말투 바꾸면 답도 바뀌는가"

- **하는 일**: 동일한 질문을 다른 말투/순서로 5번 물었을 때 답이 얼마나 일관적인지 측정
- **비유**: 정직한 학생이라면 "프랑스 수도는?" 이나 "what's the capital of France?" 이나 "프랑스의 행정 중심지가 어디지?" 든 다 "파리"로 답해야 함. 답이 흔들리면 진짜로 안다기보다 prompt 표면을 보고 추측하는 것.

```
질문 5가지 변형         답                  분산
────────────────────  ─────────────────  ─────
"X의 Y는?"             정답 A              ←┐
"What's Y of X?"       정답 A               ├ 일관 → 진짜 앎
"Y와 X 관계?"          정답 A              ←┘
"X에 대해 알려줘"       정답 A
"Y 정보 줘"             정답 B              ← 흔들림 → prompt-sensitive
                                            (표면 단서 의존)
```

- **driving target**: prompt template auto-select · 5-prompt consistency gate
- **finding 후보**: 5-prompt agreement rate · prompt 분산 · invariance score
- **vs 기존**: SANDBOX (bench reproducibility) 와 인접하지만, SANDBOX = "**같은 prompt** 다른 manifest" · PROMPT-SENS = "**다른 prompt** 같은 task" — 직각.

---

### 🥇 5. `ENERGY` 🔋 — "토큰 1개당 배터리 얼마"

- **하는 일**: 학습·추론·서빙의 에너지 소모를 watt·joule·gCO2 단위로 측정
- **비유**: 자동차 연비처럼. 같은 거리(태스크)를 가는데 어느 모델이 휘발유(전기)를 덜 먹나. 비싼 GPU 켜놓는 시간 vs 답의 가치.

```
energy/token (mJ)
   100 ┤  ▒▒▒  ← dense 70B (full)
       │    ▒▒
    50 ┤      ▒▒  ← MoE active 8B
       │        ▒▒▒
    10 ┤           ▒▒▒  ← int4 quant 7B
       │             ▒▒▒
     1 ┤                ▒▒▒  ← speculative + cache
       └────────────────────▶
       full →→→ optimization →→→ minimal
```

- **driving target**: power-aware batch size · DVFS schedule · region-time routing (저전력 시간대로 학습 이동)
- **finding 후보**: tokens/J · thermal throttle 한계 · DVFS sweet spot
- **vs 기존**: OPS = "초당 처리량" (시간 차원). ENERGY = "**같은 처리량의 비용**" (에너지 차원) — 직각.

---

### 🥇 6. `RAG` 🔍 — "도서관 사서 정확도"

- **하는 일**: 외부 지식 검색(retrieve)이 얼마나 정확하고 모델이 그 검색 결과를 얼마나 잘 활용하는지 측정
- **비유**: 도서관 사서한테 "X에 대한 책 줘" 했을 때 (1) 진짜 X 관련 책을 가져오는가 (retrieve) (2) 모델이 그 책을 읽고 답에 쓰는가 (use) 두 단계.

```
질문 ──▶ retriever ──▶ context [k=5 docs] ──▶ LLM ──▶ 답
        ↑                    ↑                  ↑
        recall@k             noise filter        활용률
        (정답 doc 포함?)      (관련 없는 buffer)  (답에 인용?)
```

- **driving target**: retriever 모델 선택 · reranker on/off · k 결정 · context budget 분배
- **finding 후보**: recall@k · noise robustness · 인용 정확도
- **vs 기존**: SUBSTRATE 는 모델 자체 능력. RAG = "**모델 + 외부 메모리**" 의 결합 능력 — 별 시스템.

---

### 🥇 7. `AGENT` 🛠️ — "공구상자 골라쓰기"

- **하는 일**: 모델이 여러 tool(검색·계산기·코드실행·API) 중 적절한 걸 골라 multi-step 으로 사용하는 능력 측정
- **비유**: 못을 박을 때 망치를, 나사를 돌릴 때 드라이버를 골라야 합니다. AGENT 는 "어느 공구를?" 과 "몇 번 두드릴지?" 를 결정.

```
질문: "100유로 = 몇 원?"

❌ naive:  [LLM 환각으로 답]   "약 14만원입니다"  ← 옛 환율로 추측

✅ AGENT:  [LLM] → tool call: get_rate("EUR","KRW")
                                    ↓
                            [API] → 1.45 (실시간)
                                    ↓
                     [LLM] → tool call: multiply(100, 1450)
                                    ↓
                            [calc] → 145000
                                    ↓
                     "145,000원입니다 (실시간 환율)"
```

- **driving target**: tool routing · plan 깊이 한계 · 에러 복구 정책
- **finding 후보**: tool-call 정확도 · multi-step plan 성공률 · 에러 복구율
- **vs 기존**: 전혀 새 dimension — 기존 sibling 은 모두 "1턴 응답" 측정, AGENT 는 "**여러 턴 도구 사용**".

---

### 🥇 8. `CONTAMINATION` ⚠️ — "시험 답안지 미리 봤나"

- **하는 일**: 평가 벤치마크 데이터가 학습 데이터에 섞여 들어가 모델이 "외운" 결과를 측정한 것인지 검출
- **비유**: 시험 보는데 알고 보니 같은 문제가 교과서에 있었어요. 그럼 그건 진짜 실력일까, 외운 걸까? CONTAMINATION 은 학습 corpus 에서 eval 문제의 n-gram match 빈도로 누설을 측정.

```
eval set:  ["Q1: 프랑스 수도?", "Q2: ...", ...]
                ↓ n-gram scan
train corpus: [...앞부분..."Q1: 프랑스 수도?" ✗  외운 거!
                            "...관련 사실"
                ...]
                ↓
contamination rate: 23/50 (46%) ← 너무 높음
                ↓
eval 점수 → 외운 점수 + 실력 점수로 분리
```

- **driving target**: eval 통과 기준 조정 (외운 문제 제외) · dataset filter at pretrain
- **finding 후보**: n-gram contamination rate · perplexity outlier
- **vs 기존**: SANDBOX 와 매우 인접하지만, SANDBOX = "측정의 reproducibility", CONTAMINATION = "**측정 자체의 무결성**" — meta-eval. 별 lane.

---

### 🥈 9. `INSTRUCTION-FOLLOWING` 📋 — "레시피 단계별 정확히 따르기"

- **하는 일**: "JSON 형식으로", "5단어 이하로", "한 줄에 하나씩" 같은 형식 지시를 모델이 얼마나 정확히 지키는지 측정
- **비유**: 요리 레시피의 "소금 1티스푼" 을 "1숟갈" 로 바꾸면 망친 음식. 형식 지시도 그래요.

```
지시: "5단어 이하로, 마침표 없이"

❌ "프랑스의 수도는 파리입니다."     ← 7단어 + 마침표
🟡 "프랑스 수도는 파리"               ← 4단어, 좋아
✅ "파리"                              ← 1단어, 베스트
```

- **driving target**: response template 선택 · system prompt 강화 · format-constraint decoder
- **finding 후보**: IFEval format compliance · constraint 준수율
- **vs 기존**: 새 dimension — 기존은 모두 "정답 맞히기" 측정, IF 는 "**형식 지키기**".

---

### 🥈 10. `MULTILINGUAL` 🌐 — "여러 언어 실력 갭"

- **하는 일**: 같은 task 를 영어 vs 한국어 vs 스와힐리어 등으로 했을 때 성능 갭과 토크나이저 효율을 측정
- **비유**: 어떤 사람이 영어는 잘 하는데 한국어로 같은 질문 하면 답이 떨어지는가? 그리고 한국어 답하는 데 글자수가 영어 2배 들면 비용도 2배.

```
영어:     "the capital of france" → [the, capital, of, france]  4 tokens
한국어:   "프랑스의 수도"           → [프, 랑, 스, 의, 수, 도]    6 tokens (1.5×)
스와힐리: "mji mkuu wa ufaransa"   → [m, ji, m, ku, u, ...]    13 tokens (3.25×)

         ↓ 같은 정보 인데 토큰 수 차이 ↓
         같은 모델·같은 비용 → 언어별 효율 달라짐
```

- **driving target**: tokenizer 학습 데이터 비율 조정 · 언어별 모델 선택 · 다국어 RLHF
- **finding 후보**: per-language perplexity · bytes/token 효율 · gap 측정
- **vs 기존**: SUBSTRATE 는 보통 영어로 측정. MULTILINGUAL = "**언어 간 일반화**" — 직각 차원.

---

### 🥈 11. `FAIRNESS` ⚖️ — "그룹별 차별 없는가"

- **하는 일**: 같은 task 를 다른 인구 그룹(직업·성별·인종 등) 명사로 바꿔 물었을 때 성능 격차나 stereotyping rate 측정
- **비유**: 면접관이 같은 자격의 두 지원자를 다르게 평가하면 차별. LLM 도 "의사 X" vs "간호사 Y" 에 대해 stereotype 응답을 다르게 내면 fairness 위반.

```
질문 변형 (같은 task, 다른 그룹 명사):
  "그 의사는 책을 ___" → "읽었다 (80%)" / "썼다 (20%)"
  "그 간호사는 책을 ___" → "읽었다 (50%)" / "썼다 (10%)" / "간호했다 (40%)"
                                                          ↑
                                                stereotype 누설
```

- **driving target**: DPO 데이터 선택 · refusal 기준 · stereotype regularization
- **finding 후보**: group-wise accuracy gap · stereotype rate · counterfactual fairness
- **vs 기존**: SAFETY 와 일부 겹치지만, SAFETY = "유해 출력 거부" · FAIRNESS = "**중립일 때 균형**" — 정직-거부와 별 lane.

---

### 🥈 12. `PRIVACY` 🔒 — "학습 데이터 누설 점검"

- **하는 일**: 모델이 학습 corpus 의 개인정보·저작권 텍스트를 "외워서" 그대로 뱉어내는지 측정
- **비유**: 시험 본 학생이 교과서를 통째로 외워 그 부분 그대로 쓸 줄 알면 "지식" 이 아니라 "복제" 임. LLM 도 그러면 저작권·프라이버시 위험.

```
prompt: "John Smith's SSN is"
   ❌ 모델 답: "123-45-6789"        ← 학습 데이터 그대로 복원 (membership inference HIT)
   ✅ 모델 답: "I cannot share..."  ← 거부

prompt: "Harry Potter book 1 chapter 1 starts:"
   ❌ "Mr. and Mrs. Dursley, of number four..."  ← 저작권 텍스트 그대로
   ✅ "I can't reproduce copyrighted text..."   ← 거부
```

- **driving target**: DP-SGD noise schedule · 학습 데이터 redaction gate · refusal at extraction prompt
- **finding 후보**: membership inference accuracy · canary extraction rate · DP ε
- **vs 기존**: SAFETY 인접하지만, SAFETY = "유해 응답 거부" · PRIVACY = "**학습 흔적 보호**" — 시간(학습→추론) 차원의 별 lane.

---

## 🛠️ ⭐⭐ 10개 — 보조 후보 (간략 카드)

| # | axis | 별칭 | 한 줄 | 비유 |
|---|------|------|------|------|
| 13 | `ROBUSTNESS` 🛡️ | "흔들어도 안 무너지나" | 적대적 입력·OOD 에서 성능 유지 | 바람 불어도 안 넘어지는 우산 |
| 14 | `TRAINING-DYNAMICS` 📈 | "학습 곡선 의사" | loss-spike·grokking 임계 측정 | 운동선수의 기록 그래프 (slump/breakthrough 시점) |
| 15 | `DATA-EFFICIENCY` 🍽️ | "공부 순서 다이어트" | curriculum·sample-eff 측정 | 쉬운 문제 먼저 vs 어려운 문제 먼저, 어느 게 빨라? |
| 16 | `HW-VARIANCE` 🎲 | "GPU 복권" | 같은 spec 칩 간 throughput 분산 | 같은 모델 휴대폰도 발열·속도 차이 있음 |
| 17 | `BATCH-COMPOSITION` 📦 | "한 박스 안 섞기" | 길이·난이도 mix 의 throughput 영향 | 우편물 분류 효율 |
| 18 | `RELIABILITY` 🔧 | "오타 안 나는가" | silent corruption·결정론 재현성 | 같은 텍스트 두 번 인쇄해서 같은가 |
| 19 | `CARBON` 🌳 | "탄소 발자국" | gCO2/token · region별 grid carbon | 친환경 시간대에 빨래 돌리기 |
| 20 | `TEMPORAL` 🕰️ | "시간 감각" | 날짜·기간·순서 정확도·cutoff 인지 | "어제가 며칠?" 물었을 때 정확히 답하는가 |
| 21 | `DIVERSITY` 🎨 | "같은 답만 하지 않는가" | self-BLEU·분포 entropy·반복률 | 똑같은 농담만 반복하는 친구 |
| 22 | `USER-MODEL` 👤 | "대화 흐름 기억" | persona 일관성·multi-turn drift | 처음과 끝의 말투가 같은가 |

---

## 🔧 ENGINE N 축 family 확장 (sibling 아님 — N1 자매)

> 이건 별 sibling 이 아니라 ENGINE 의 self-meta N 축 family 의 확장. wire 자체에 대한 측정.

### N2 `WIRE-DECAY` ⏳ — "옛 처방의 약효 만료"

- 하는 일: 기존 wire 가 sibling finding 갱신을 따라가는지 (decay 측정)
- 비유: 옛 의사 처방전이 새 진단에 안 맞게 되는 것. 약 유효기간 같은 거예요.
```
sibling 도메인 새 finding ──▶ 기존 wire 와 충돌?
                                    ↓
                            wire 재검증 schedule
```
- driving: wire 재검증 trigger · stale wire flag

### N3 `WIRE-INTERFERENCE` ⚔️ — "처방전끼리 충돌"

- 하는 일: 두 wire 가 같은 LLM behavior 를 다른 방향으로 끌어당기는 충돌 frequency
- 비유: 의사 두 명이 다른 약 주면 약끼리 부작용. C1 routing 이 small-active MoE 를 고르는데 D1 selector 가 dense 를 요구하면?
```
wire C1 ↗     충돌 영역
       \  ✗  ◀━━━ 같은 결정 다른 답
wire D1 ↘
```
- driving: wire 우선순위 rule · conflict-resolution mechanism

### N4 `WIRE-COMPOSITION` 🧩 — "약 여러 개 안전 조합"

- 하는 일: 여러 wire 를 동시에 적용했을 때 잔여 정확도 측정 (additive 인가)
- 비유: 약 단독 복용 vs 함께 복용 효과 차이.
- driving: wire stacking order · 안전 조합 룰

### N5 `WIRE-ROLLBACK` ↩️ — "부작용 나오면 즉시 약 끊기"

- 하는 일: wire 적용 후 regression 감지 → 자동 rollback 가능 여부
- 비유: 약 먹고 두통 생기면 의사가 즉시 끊으라고 말함. wire 도 그래야.
- driving: rollback trigger threshold · regression detector

---

## 📁 흡수처별 분류 (16개 — sibling 안 됨)

> 이 후보들은 기존 sibling 의 sub-finding 으로 볼 수 있어 별 sibling 으로 띄우지 않음.

| 흡수처 | 후보 |
|---|---|
| **OPS** | MFU/COMPUTE-EFF · KV-CACHE · SPEC-DECODING · CACHING-LOCALITY · STREAMING-LATENCY · DEBUGGABILITY |
| **SUBSTRATE** | COMPRESSION (능력 손상 측면) · EMERGENT · MULTI-MODAL-ALIGN |
| **SAFETY** | LEGAL/JURISDICTION · REWARD-MODEL-DRIFT · HUMAN-FEEDBACK-EFF |
| **SANDBOX** | EVAL-METHODOLOGY · COST-OF-EVAL |
| **lm_foundry** | MATH-LLM · CODE-LLM (lm_foundry 트랙 페어) |
| **약한 후보 (⭐ 1)** | ACCESSIBILITY · FEDERATED/DECENTRAL (hexa-grid 이관) · TOKENIZER-DRIFT · WATERMARK · CONTINUAL-LEARN · CONSENSUS-ENSEMBLE |

---

## 🎯 즉시 wire 가능한 Top-3 추천 (다음 ENGINE round 후보)

> measured finding 이 이미 존재할 가능성 + closed-form 단순함 + driving target 명확성 기준.

| 순위 | axis | 왜 |
|---|---|---|
| 🥇 1 | **CALIBRATION** 📏 | ECE 공식이 가장 closed-form 단순 · abstention threshold 즉시 wire 가능 · SANDBOX eval 결과 일부 재가공으로 finding 확보 |
| 🥈 2 | **HALLUCINATION** 💭 | factual recall 측정 기존 벤치 (TruthfulQA·SimpleQA) 활용 가능 · uncertainty-gated output 단순 |
| 🥉 3 | **LONG-CONTEXT** 📜 | needle-in-haystack 표준 protocol · RoPE θ scaling 닫힌형 식 존재 (NTK-aware scaling) |

---

## 📊 통계 (R1~R8 누적)

```
brainstorm 총 idea:           49
   ├── 진짜 novel sibling 후보: 22  (⭐⭐⭐ 12 + ⭐⭐ 10)
   ├── 기존 6 sibling 흡수:     16
   ├── ENGINE N 축 family 확장:  4  (N2~N5)
   └── 약한 후보 / 폐기:         7
                                ────
                                49

🛑 R8 에서 신규 ⭐⭐⭐ = 0 → DEPLETION 종료
   (R1: 8 후보 · R2: 5 · R3: 8 · R4: 8 · R5: 4 · R6: 정리 · R7: 7 · R8: 4 약함)
```

## orchestra-research 20-skill 흡수 매핑 (2026-05-28 cycle-10)

> 외부 reference [orchestra-research.com/perspectives/ai-research-skills](https://www.orchestra-research.com/perspectives/ai-research-skills) 의 20 AI research skill 을 hexa-codex 측정 도메인과 전수 매핑 → 16 커버 + 4 누락 흡수 = **20/20 전부 커버**.

| orchestra skill | hexa-codex 도메인 | 상태 |
|---|---|---|
| Tokenization | MULTILINGUAL/N1 | ✅ |
| Mechanistic Interpretability | NEUROEXP | ✅ |
| Distributed Training | HW-VARIANCE/N1 | ✅ |
| Inference & Serving | BATCH-COMPOSITION · LONG-CONTEXT/N2 · ENERGY | ✅ |
| Safety & Alignment | SAFETY · ROBUSTNESS/N1 | ✅ |
| Evaluation | (전체 측정 도메인) | ✅ |
| Infrastructure | HW-VARIANCE · OPS | ✅ |
| Agents | AGENT/N1 | ✅ |
| RAG | RAG | ✅ |
| Multimodal | MULTIMODAL | ✅ |
| Prompt Engineering | PROMPT-SENSITIVITY | ✅ |
| Emerging Techniques | 각 N⭐ (구 FRONTIER 흡수) | ✅ |
| ML Paper Writing | /paper skill | ✅ |
| Fine-Tuning | DATA-EFFICIENCY | △ 부분 |
| Optimization | ENERGY · ECONOMICS | △ 부분 |
| MLOps | OPS | △ 부분 |
| **Model Architecture** | **ARCHITECTURE** (신규 흡수) | 🆕 ✅ |
| **Data Processing** | **DATA-QUALITY** (신규 흡수) | 🆕 ✅ |
| **Post-Training** | **POST-TRAINING** (신규 흡수) | 🆕 ✅ |
| **Observability** | **OBSERVABILITY** (신규 흡수) | 🆕 ✅ |

신규 4 도메인 (A1 closed-form 7/7 · perpetual @goal · N⭐ MAIN):
- 🏗️ ARCHITECTURE — attention quality-per-FLOP (MLA 1.84× · naive 0.75× fires) · `0ca96cf`
- 🧹 DATA-QUALITY — dedup-gain (common_crawl 65%dup +7.5pp · curated 3%dup fires) · `19a4f01`
- 🎓 POST-TRAINING — alignment-tax (over_aligned 12pp drop fires) · `f5765c5`
- 📡 OBSERVABILITY — drift-detection latency (blind_big 30%·4batch fires) · `aacab64`

## VERTICAL/* 전문 모델 측정군 + 범용 (2026-05-28 cycle-10 · "실제 생성되는 전문 모델")

> 사용자 directive: "실제로 생성되는 전문 모델 (코드·바이오 등)". vertical specialized LLM 측정 도메인군 (VERTICAL/* 그룹 폴더) + 범용 generalist (OFFICE · horizontal 짝). "Small is the New Big" (DSLM frontier · vertical AI 시장 $10.2B→$115.4B 2034) 반영.

| 도메인 | 아이콘 | A1 핵심 측정 | commit |
|---|---|---|---|
| CODE | 🖥️ | pass@k oneshot-ratio (lm_foundry Mk.I) | 6ee7ed1 |
| BIO | 🧬 | specialization-gain (생명과학) | 431d916 |
| MATH | 🔢 | formal-proof 검증율 (답≠증명) | 882ce5a |
| LAW | ⚖️ | 판례 hallucination (Mata v.Avianca) | 9a7c372 |
| MEDICAL | 🏥 | 임상안전 confident-wrong (환자위험) | 70db36d |
| FINANCE | 💰 | 수치추론 (금융 정밀) | 9e41cc6 |
| SCIENCE | 🔬 | multi-step 유도 (사실≠유도) | cf91cfa |
| ROBOTICS | 🦾 | sim→real (reality gap) | 13ce598 |
| MATERIALS | 🧪 | in-silico↔합성 gap (GNoME) | 83db35f |
| WEATHER | ⛅ | forecast skill vs NWP (chaos) | 953e38d |
| CYBERSECURITY | 🛡️ | 취약점 탐지 (defensive · Foundation-Sec) | 65ed974 |
| OFFICE | 🏢 | generalist-vs-specialist gap (메타검증) | deaba13 |

- 각 A1 closed-form 7/7 · perpetual @goal · N⭐ MAIN.
- VERTICAL (전문 깊이 11) ⊥ OFFICE (범용 넓이 1) — OFFICE 의 falsifier 가 VERTICAL 존재 정당성 메타검증 (generalist < 전문 × 0.7 → DSLM 정당화).
- 측정 layer 만 — 실제 생성 recipe 는 lm_foundry (code Mk.I) · lm_foundry/docs/bio-llm.md (bio).

## Cross-refs

- ENGINE 도메인 SSOT: [`ENGINE/ENGINE.md`](ENGINE/ENGINE.md) (현재 6 sibling intake matrix)
- 도메인 roster: [`DOMAINS.tape`](DOMAINS.tape)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- brainstorm 세션: 2026-05-27 (8 rounds, depletion 도달)
- 신규 sibling 승격 절차: ① ⭐⭐⭐ 후보 선택 → ② finding measured 확보 → ③ ENGINE matrix 행 추가 → ④ `/domain init <NAME>` (필요 시 별 도메인 SSOT) → ⑤ ENGINE 축 letter 부여 (G, H, ...)
