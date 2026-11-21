# 규칙: 완료와 검증 (CMP)

언제 끝났다고 말할 수 있는지, 어떻게 확인하는지를 정하는 규칙이다.

### R-CMP-001  완료 기준을 적는다
- scope: common
- applies_to: instruction, user_prompt
- severity: high
- status: active
- source: S-01
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: 결과물이 어떤 조건을 만족하면 끝인지 없음
- 고치는 법: "다음이 모두 참이면 완료"로 확인 가능한 조건을 나열한다
- Before: 온보딩 문서 만들어줘.
- After: 신규 입사자가 이 문서만 보고 개발 환경 설치, 테스트 실행, 첫 PR 생성까지 할 수 있으면 완료다.

### R-CMP-002  실제 검증 방법을 적는다
- scope: common
- applies_to: instruction, user_prompt
- severity: high
- status: active
- source: S-03
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: 코드, 쿼리, 데이터 작업인데 테스트, 빌드, 대조 같은 확인 지시가 없음
- 고치는 법: 완료 보고 전에 변경을 실제로 실행해 보는 검사(테스트, 타입 검사, 빌드, 샘플 대조)를 하라고 적는다
- Before: 이 SQL 고쳐줘.
- After: 이 SQL을 고친 뒤 샘플 데이터로 실행해 결과 행 수가 원본 리포트와 같은지 확인하고 보고해.

### R-CMP-003  검증하지 못한 것은 보고하게 한다
- scope: common
- applies_to: instruction
- severity: medium
- status: active
- source: S-03
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: 검증이 불가능할 때의 행동이 없음, 답을 모를 때의 처리가 없음
- 고치는 법: 실행하지 못한 검사와 그 이유, 자료에 없어서 답하지 못한 부분을 밝히게 한다
- Before: 고객 질문에 답해.
- After: 제공된 자료로 답할 수 없는 질문은 추측하지 말고 "자료에서 확인되지 않는다"고 답한 뒤 상담원 연결을 안내한다.

### R-CMP-004  끝까지 수행하게 한다
- scope: claude
- applies_to: instruction
- severity: medium
- status: active
- source: S-03, S-04
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: 여러 단계를 수행하는 에이전트인데 조기 중단에 대한 지침이 없음
- 고치는 법: 요청받은 일이 모두 끝날 때까지 계속하고, 남은 일이 있으면 멈추지 말라고 적는다. 위험한 작업의 확인 규칙은 그대로 둔다
- Before: (지침에 완료 관련 문장 없음)
- After: 요청받은 일이 모두 끝날 때까지 계속 작업한다. 확인이 필요한 작업에 도달했을 때만 멈추고 묻는다.
