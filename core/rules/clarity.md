# 규칙: 명확성 (CLR)

모호한 지시를 측정 가능하고 실행 가능한 지시로 바꾸는 규칙이다.

### R-CLR-001  실행인지 제안인지 명시한다
- scope: common
- applies_to: instruction, user_prompt
- severity: high
- status: active
- source: S-01
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: "~해줄 수 있어?", "봐줘", "어때?"로 끝나는데 결과물이 실제로 바뀌기를 기대함
- 고치는 법: 원하는 행동을 명령형 동사로 쓴다. 제안만 원하면 "수정하지 말고 제안만 해"라고 쓴다
- Before: 이 함수 성능 좀 봐줄 수 있어?
- After: 이 함수를 응답 시간이 200ms 이하가 되도록 수정해. 바꾼 이유를 줄마다 주석으로 남겨.

### R-CLR-002  모호한 형용사를 측정 가능한 기준으로 바꾼다
- scope: common
- applies_to: instruction, user_prompt
- severity: high
- status: active
- source: S-01
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: "좋게", "자세히", "간단히", "적당히", "깔끔하게"처럼 기준이 없는 형용사
- 고치는 법: 길이, 개수, 수준, 대상 같은 확인 가능한 기준으로 바꾼다
- Before: 회의록을 간단하게 정리해줘.
- After: 회의록을 결정 사항, 담당자별 할 일, 미결 사항 세 구역으로 나눠 각 5줄 이내로 정리해.

### R-CLR-003  순서나 완전성이 중요하면 번호 단계로 쓴다
- scope: common
- applies_to: instruction, user_prompt
- severity: medium
- status: active
- source: S-01
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: 여러 작업이 한 문장에 쉼표로 나열됨, 순서가 중요한 절차가 산문으로 섞임
- 고치는 법: 순서대로 번호를 매기고 한 단계에 한 행동만 둔다
- Before: 데이터 정제하고 이상치 보고 차트도 만들고 요약해줘.
- After: 1. 결측치가 있는 행을 제거한다 2. 평균에서 3표준편차를 벗어난 값을 표시한다 3. 월별 추이 차트를 만든다 4. 핵심 발견 3개를 요약한다

### R-CLR-004  기대 수준 이상을 원하면 명시한다
- scope: claude
- applies_to: instruction, user_prompt
- severity: medium
- status: active
- source: S-01
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: "알아서 잘", 범위 없이 "최고로", 기본 요청만 적고 풍부한 결과를 기대함
- 고치는 법: 최신 모델은 요청한 만큼 정확히 하므로, 원하는 추가 요소를 구체적으로 적는다
- Before: 상담봇 FAQ 화면 문구 만들어줘.
- After: 상담봇 FAQ 화면 문구를 만들어. 질문 10개와 답변, 빈 검색 결과 안내 문구, 상담원 연결 버튼 문구까지 포함해.
