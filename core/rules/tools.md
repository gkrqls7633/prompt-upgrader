# 규칙: 도구와 스킬 (TOL)

에이전트가 보유한 도구를 언제, 어떻게, 얼마나 쓰는지 가르치는 규칙이다. 도구 설명은 그 에이전트의 숙련도다.

### R-TOL-001  도구마다 쓸 때와 쓰지 않을 때를 쓴다
- scope: common
- applies_to: instruction
- severity: high
- status: active
- source: S-01, S-04
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: 도구 이름만 나열되어 있고 사용 조건이 없음
- 고치는 법: 도구마다 "~할 때 쓴다", "~일 때는 쓰지 않는다"를 한 줄씩 적는다
- Before: 사용 가능 도구: search_docs, run_sql, send_email
- After: search_docs: 사내 규정을 근거로 답해야 할 때 쓴다. 일반 상식 질문에는 쓰지 않는다. run_sql: 수치를 확인해야 할 때 읽기 전용 쿼리로만 쓴다.

### R-TOL-002  "애매하면 [도구]" 같은 포괄 규칙을 쓰지 않는다
- scope: claude
- applies_to: instruction
- severity: medium
- status: active
- source: S-01
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: "if in doubt, use", "확실하지 않으면 항상 검색", "모든 질문에 먼저 도구를"
- 고치는 법: 도구가 실제로 판단에 도움이 되는 조건으로 좁혀 쓴다
- Before: 확실하지 않으면 항상 search_docs를 먼저 호출해.
- After: 답이 사내 규정이나 최근 공지에 달려 있을 때 search_docs를 호출한다.

### R-TOL-003  강한 강조로 도구 사용을 강제하지 않는다
- scope: claude
- applies_to: instruction
- severity: high
- status: active
- source: S-01
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: "CRITICAL: You MUST use [tool]", "반드시 무조건 [도구]를 호출"
- 고치는 법: "[도구]는 ~할 때 사용한다"처럼 평서문과 조건으로 쓴다
- Before: CRITICAL: You MUST use the calculator tool for ANY number.
- After: 세 자리 이상 곱셈이나 비율 계산은 calculator 도구로 한다. 암산 오류를 막기 위해서다.

### R-TOL-004  독립 호출은 병렬로, 의존 호출은 순서대로, 값은 추측하지 않는다
- scope: claude
- applies_to: instruction
- severity: low
- status: active
- source: S-01
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: 여러 도구를 쓰는 에이전트인데 호출 순서나 누락 값 처리 지침이 없음
- 고치는 법: 서로 의존하지 않는 호출은 동시에, 앞 결과가 필요한 호출은 순서대로 하고, 빠진 값은 추측하지 말고 확인하라고 적는다
- Before: 필요한 도구를 호출해서 답해.
- After: 서로 의존하지 않는 조회는 동시에 호출한다. 앞 결과가 필요한 호출은 순서대로 한다. 필요한 값이 없으면 추측하지 말고 사용자에게 묻는다.

### R-TOL-005  비용이 큰 도구는 비용과 쓸 기준을 적는다
- scope: claude
- applies_to: instruction
- severity: medium
- status: active
- source: S-04
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: 서브에이전트, 외부 유료 API, 대용량 조회 도구에 비용 설명이 없음
- 고치는 법: 도구 설명에 비용(시간, 토큰, 금액)과 그 비용을 쓸 가치가 있는 경우를 적는다
- Before: spawn_agent: 하위 에이전트를 실행한다.
- After: spawn_agent: 하위 에이전트를 실행한다. 맥락을 처음부터 다시 읽어 비용이 크다. 서로 독립적인 조사를 동시에 돌릴 때만 쓴다.

### R-TOL-006  검색 도구가 있으면 오늘 날짜를 주고 무조건 검색 지시는 피한다
- scope: claude
- applies_to: instruction
- severity: medium
- status: active
- source: S-03
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: 웹 검색 도구가 있는데 날짜 정보가 없음, "현재 사실 질문은 모두 검색"
- 고치는 법: 오늘 날짜를 주고, 검색이 필요한 조건(최신 정보, 가격, 일정)을 좁혀 적는다. 근거 문서는 Haiku 5.5 기준이다
- Before: 현재와 관련된 모든 질문은 웹 검색해서 답해.
- After: 오늘은 {{date}}이다. 가격, 일정, 최근 발표처럼 학습 이후 바뀌었을 수 있는 정보는 웹 검색으로 확인한다.
