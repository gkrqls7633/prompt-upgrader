# 규칙: 출력 (OUT)

결과물의 형태를 정해 바로 쓸 수 있게 만드는 규칙이다.

### R-OUT-001  원하는 출력 형식을 명시한다
- scope: common
- applies_to: instruction, user_prompt
- severity: high
- status: active
- source: S-01
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: 형식, 구조, 매체 지정 없음 (표인지, 문단인지, JSON인지)
- 고치는 법: 결과물의 구조와 형식을 적는다. 시스템이 받아 쓰면 스키마까지 적는다
- Before: 고객 리뷰 분석해줘.
- After: 고객 리뷰를 분석해 `긍정|부정|중립` 비율 표와, 부정 리뷰의 주요 불만 상위 3개를 각각 대표 인용 1개와 함께 정리해.

### R-OUT-002  프롬프트 문체를 원하는 출력 문체에 맞춘다
- scope: claude
- applies_to: instruction
- severity: low
- status: active
- source: S-01
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: 산문 응답을 원하면서 지침 자체가 글머리표와 굵은 글씨 범벅
- 고치는 법: 산문을 원하면 지침도 산문으로, 간결한 응답을 원하면 지침도 간결하게 쓴다
- Before: (글머리표 40개로 된 지침) + "응답은 자연스러운 문단으로"
- After: 응답 문체 관련 부분을 문단으로 다시 쓰고, 글머리표는 절차와 목록에만 남긴다

### R-OUT-003  길이와 분량, 정렬 기준을 지정한다
- scope: common
- applies_to: instruction, user_prompt
- severity: medium
- status: active
- source: S-01
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: "몇 가지", "간략히", "주요한 것들"처럼 분량 기준이 없음
- 고치는 법: 개수, 길이, 정렬 순서를 숫자와 기준으로 적는다
- Before: 기획안의 문제점 몇 가지 알려줘.
- After: 기획안의 문제점 5개를 심각도가 높은 순서로, 각 2문장 이내로 알려줘.
