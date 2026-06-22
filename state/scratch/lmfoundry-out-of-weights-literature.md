# out-of-weights routing — 문헌 prior (web research, 2026-06-22)

> Scratch research note (docs scratchDir). NOT an ARCHITECTURE.json node.
> 목적: $18 GPU 재오픈 학습 발사 전, 기존 학계 문헌이 falsifier 결과를 이미
> 시사하는지 확인 (한계효용 판단). 서술 korean, 인용/제목 english.
> 짝: lmfoundry-out-of-weights-{design,preflight}.md · frontier-gap.json out-of-weights-routing leaf.

## 0. 한 줄 결론
기존 문헌은 우리 out-of-weights 결론을 **강하게 지지**한다 — (a) external classifier 라우팅이
학계 주류이고, (b) in-weight tool/function-call 파인튜닝은 catastrophic forgetting으로
일반능력을 떨어뜨린다는 게 다수 논문에서 반복 관측됨(우리 5 failure mode와 수렴). 따라서
$18 재오픈 학습의 결과는 문헌상 **거의 예측 가능**(in-weight가 진다). 단 "7B specialist의
hexa-canon 토큰 emission 보존"이라는 우리 특정 regime은 문헌에 정확히 없어 novelty는 유지.

## 1. external router(=out-of-weights)가 학계 주류
| 연구 | 요지 | 우리와의 관계 |
|---|---|---|
| RouteLLM (2024, arXiv:2406.18665) | preference data로 **별도 학습 router**가 strong/weak LLM 선택; binary classifier | out-of-weights 분류기와 동일 패러다임 |
| HybridLLM | 대부분 small model + 일부만 large로 라우팅하는 **binary classifier** | tier 라우팅 동일 |
| xRouter (2025, arXiv:2510.08439) | external orchestration을 **RL로 학습** (cost-aware) | 외부 라우팅이 활발한 방향 |
| vLLM Semantic Router (2026, arXiv:2603.21354) | Workload-Router-Pool 아키텍처 | 외부 라우팅 인프라화 |
| Universal Model Routing (arXiv:2502.08773), MoErging survey (2408.07057) | meta-model / kNN / matrix-factorization router | 라우터=별도 모듈이 표준 |

→ 핵심: 학계는 라우팅 결정을 **모델 가중치 밖의 분류기**에 두는 방향으로 수렴. 우리 결론과 일치.

## 2. in-weight tool-learning → catastrophic forgetting (우리 5 failure mode와 동일)
| 연구 | 관측 | 우리와의 관계 |
|---|---|---|
| Function Vectors / Continual Instruction Tuning (arXiv:2502.11019) | function-call 파인튜닝 후 MMLU·GSM8K·Arc·HellaSwag·Winogrande·TruthfulQA **하락** | canon emission 저하 = 같은 현상 |
| Alopex on-device function calls (arXiv:2411.05209) | tool-call 능력↑ 이지만 other abilities↓ | trade-off 동일 |
| Hierarchical regularization (arXiv:2501.13669), SDFT self-distillation | 완화책 제안 — 그러나 trade-off 자체는 인정 | — |

**완화책 = pretraining/textbook data 1:1 혼합**이 표준 권고인데, 우리가 이미 시도:
- r40 SFT-25% mix → Mk.I 82.71% (specialist 붕괴)
- r41 SFT-9% mix → 83.01% (여전히 erosion)
즉 학계 표준 완화책을 우리 regime에서 돌렸고 **실패**했다. 이게 우리 결과의 강한 근거.

## 3. $18 재오픈 학습의 한계효용 판정
- **문헌이 답하는 부분 (재학습 불필요)**: "in-weight tool-learning이 external classifier보다
  canon/일반능력 보존에서 불리한가?" → YES (문헌 일관). 우리 r40–r43 5 failure mode가 이를 재현.
- **문헌이 답 못하는 부분 (novelty, 측정 가치)**: "7B-specialist + r=64 LoRA + hexa-canon emission
  보존 regime에서, 동일예산 in-weight가 3-gate(0.9833 분류 · 94.29% Mk.I · canon 무저하)를
  동시 통과할 수 있는가?" → 문헌에 정확한 선례 없음. 단 §2 prior상 **통과 가능성 낮음**.
- **결론**: $18은 "이미 강한 prior가 있는 결과의 확정 도장". 발견 기대값 낮음 →
  **보류가 합리적**(문헌 prior로 lane 결론 강화). 발사한다면 novelty=특정 regime 확정뿐.

## 4. 출처
- RouteLLM: arXiv:2406.18665
- xRouter: arXiv:2510.08439
- vLLM Semantic Router (vision): arXiv:2603.21354
- Universal Model Routing: arXiv:2502.08773
- MoErging survey: arXiv:2408.07057
- Function Vectors / continual instruction tuning forgetting: arXiv:2502.11019
- Alopex on-device function calls: arXiv:2411.05209
- Hierarchical layer/element regularization: arXiv:2501.13669
