# 규칙: 구식 패턴 (LEG)

예전 모델에서는 통했지만 최신 Claude 모델에서는 오류를 내거나 효과가 없는 패턴이다. 모두 Claude 전용이다.

### R-LEG-001  마지막 assistant 턴 prefill에 의존하지 않는다
- scope: claude
- applies_to: instruction
- severity: high
- status: active
- source: S-01
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: assistant 메시지를 미리 채워 응답을 시작시키는 방식, "응답을 { 로 시작하도록 prefill". Claude 4.6 이후 400 오류
- 고치는 법: 구조화 출력, 직접 지시("서론 없이 바로 답해"), enum이 있는 도구로 바꾼다
- Before: assistant 턴을 `{"category": "` 로 미리 채워 분류 결과를 받는다.
- After: 구조화 출력의 JSON 스키마로 category를 `["배송","환불","결제","기타"]` enum으로 정의한다.

### R-LEG-002  budget_tokens 대신 adaptive thinking과 effort를 쓴다
- scope: claude
- applies_to: instruction
- severity: high
- status: active
- source: S-01, S-03
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: thinking 설정에 budget_tokens 지정. Claude 4.7 이후와 Haiku 5.5에서 400 오류
- 고치는 법: thinking은 adaptive로 두고 사고량은 effort(low, medium, high 등)로 조절한다
- Before: thinking: {type: "enabled", budget_tokens: 8000}
- After: thinking: {type: "adaptive"}, effort: "high"

### R-LEG-003  "생각하지 말고 바로 답해" 대신 effort를 낮춘다
- scope: claude
- applies_to: instruction, user_prompt
- severity: low
- status: active
- source: S-04
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: "숙고하지 말고 즉답", "생각하지 말고 바로". Fable 5.2 이후 medium 이상 effort에서는 사고를 줄이지 못한다
- 고치는 법: 속도와 비용이 목적이면 문장을 지우고 effort를 낮춘다
- Before: 깊게 생각하지 말고 바로 답해.
- After: (문장 삭제, API 설정에서 effort를 low로)

### R-LEG-004  응답 안에 추론 과정을 쓰라고 하지 않는다
- scope: claude
- applies_to: instruction, user_prompt
- severity: medium
- status: active
- source: S-03
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: "생각 과정을 단계별로 응답에 모두 적어", "내부 추론을 그대로 출력". reasoning_extraction 거절을 부를 수 있다
- 고치는 법: 사고는 thinking에 맡기고, 응답에는 근거와 결론만 쓰게 한다
- Before: 답하기 전에 너의 생각 과정을 단계별로 응답에 전부 적어.
- After: 결론과 함께 그 결론을 뒷받침하는 근거 3개를 적어.

### R-LEG-005  토큰 예산 문구를 넣지 않는다
- scope: claude
- applies_to: instruction
- severity: low
- status: active
- source: S-04
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: "N 토큰 안에서 생각해", "토큰 예산은 N이다". 근거 문서에서 큰 예산 문구를 없애도 성능은 같고 비용은 줄었다
- 고치는 법: 문구 없이 같은 작업을 테스트해 보고, 차이가 없으면 지운다. 응답 길이 제한이 목적이면 출력 길이를 직접 지정한다
- Before: 너에게는 32000 토큰의 사고 예산이 있다. 충분히 써.
- After: (문구 삭제. 길이 제한이 필요하면 "응답은 5문단 이내" 같은 출력 지시로)
