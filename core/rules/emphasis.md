# 규칙: 강조와 부정 (EMP)

강조어, 금지어, 부정형 지시가 오히려 과잉 행동이나 경직을 부르는 문제를 다룬다.

### R-EMP-001  대문자 강조와 강한 강조어를 남발하지 않는다
- scope: claude
- applies_to: instruction, user_prompt
- severity: high
- status: active
- source: S-01
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: CRITICAL, MUST, IMPORTANT, 반드시(!!), 대문자 문장이 반복됨. 근거 문서는 Opus 4.5/4.6의 과잉 반응을 명시한다
- 고치는 법: 강조어를 빼고 평서문으로 쓴다. 정말 중요한 규칙은 강조 대신 이유를 붙인다
- Before: CRITICAL: You MUST ALWAYS run the linter!!!
- After: 코드를 고친 뒤에는 린터를 실행한다. 린트 오류가 있으면 CI가 실패하기 때문이다.

### R-EMP-002  절대 금지어 대신 범위와 이유를 쓴다
- scope: claude
- applies_to: instruction, user_prompt
- severity: high
- status: active
- source: S-04
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: NEVER, 절대, 무조건, 어떤 경우에도 + 이유나 예외 없음
- 고치는 법: 최신 모델은 "never"를 예외 없는 규칙으로 받아들인다. 적용 범위를 좁히고 이유와 예외를 적는다
- Before: 절대 파일을 삭제하지 마.
- After: 파일을 삭제하기 전에는 승인을 받는다. 복구할 수 없는 작업이기 때문이다. 이번 작업에서 직접 만든 임시 파일은 승인 없이 지워도 된다.

### R-EMP-003  "하지 마" 대신 "할 것"으로 쓴다
- scope: common
- applies_to: instruction, user_prompt
- severity: medium
- status: active
- source: S-01
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: 부정형 지시만 있고 원하는 행동이 없음
- 고치는 법: 금지 대신 원하는 결과를 긍정형으로 적는다
- Before: 마크다운 쓰지 마.
- After: 응답은 자연스럽게 이어지는 산문 문단으로 작성한다.
