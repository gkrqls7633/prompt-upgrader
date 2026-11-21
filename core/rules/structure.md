# 규칙: 구조 (STR)

지시, 자료, 예시를 모델이 헷갈리지 않게 배치하는 규칙이다.

### R-STR-001  지시·맥락·예시·입력을 태그로 구분한다
- scope: common
- applies_to: instruction, user_prompt
- severity: medium
- status: active
- source: S-01
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: 지시문과 붙여넣은 자료가 경계 없이 한 덩어리로 섞임
- 고치는 법: `<instructions>`, `<context>`, `<examples>`, `<input>`처럼 설명적인 태그로 감싼다
- Before: 아래 고객 문의에 답해줘 환불은 7일 이내 가능 문의: 어제 산 책 환불되나요
- After: `<policy>`환불은 구매 후 7일 이내 가능`</policy>` `<inquiry>`어제 산 책 환불되나요`</inquiry>` policy만 근거로 inquiry에 답해.

### R-STR-002  태그 이름을 일관되게 쓰고 계층은 중첩한다
- scope: common
- applies_to: instruction
- severity: low
- status: active
- source: S-01
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: 같은 종류의 내용에 다른 태그명, 여러 문서를 구분 없이 나열
- 고치는 법: 한 지침 안에서 태그명을 통일하고, 여러 문서는 `<documents>` 안에 `<document index="n">`으로 넣는다
- Before: `<doc>`약관`</doc>` `<file>`FAQ`</file>` `<자료>`공지`</자료>`
- After: `<documents><document index="1">`약관`</document><document index="2">`FAQ`</document></documents>`

### R-STR-003  예시는 3~5개, 서로 다르게, 예시 태그로 감싼다
- scope: common
- applies_to: instruction, user_prompt
- severity: medium
- status: active
- source: S-01
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: 예시가 1개뿐, 예시끼리 거의 같음, 예시와 지시의 경계가 없음
- 고치는 법: 실제 입력과 닮고 서로 다른 경우를 다루는 예시 3~5개를 `<example>` 태그로 감싼다
- Before: 예: "배송 언제 와요?" → 배송 문의
- After: `<examples>` 안에 배송, 환불, 결제 오류, 칭찬, 분류 불가 사례 5개를 각각 `<example>`로 넣는다

### R-STR-004  긴 자료는 위에, 질문과 지시는 끝에 둔다
- scope: claude
- applies_to: instruction, user_prompt
- severity: medium
- status: active
- source: S-01
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: 긴 문서(대략 2만 토큰 이상) 뒤에 질문이 없거나, 지시가 긴 자료 중간에 묻힘
- 고치는 법: 긴 자료를 프롬프트 위쪽에 두고, 질문과 지시는 맨 끝에 둔다
- Before: 이 계약서에서 위약금 조항 찾아줘. (계약서 전문 3만 자)
- After: (계약서 전문 3만 자를 `<contract>`로 감싸 먼저 두고) 위 contract에서 위약금 조항을 모두 찾아 조항 번호와 함께 나열해.

### R-STR-005  긴 문서 작업은 관련 구절 인용부터 시킨다
- scope: claude
- applies_to: instruction, user_prompt
- severity: low
- status: active
- source: S-01
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: 긴 문서를 근거로 답하게 하면서 인용 단계가 없음
- 고치는 법: 먼저 관련 구절을 `<quotes>`에 인용하게 하고, 그 인용만 근거로 답하게 한다
- Before: 이 사내 규정집 보고 재택근무 조건 알려줘.
- After: 규정집에서 재택근무와 관련된 구절을 먼저 `<quotes>`에 그대로 옮기고, 그 인용만 근거로 조건을 정리해.
