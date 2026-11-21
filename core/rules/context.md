# 규칙: 맥락 (CTX)

모델이 판단에 쓸 배경, 이유, 독자를 주는 규칙이다.

### R-CTX-001  목적과 결과물의 쓰임을 밝힌다
- scope: common
- applies_to: instruction, user_prompt
- severity: high
- status: active
- source: S-01
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: 결과물을 누가, 어디에, 무엇을 결정하는 데 쓰는지 없음
- 고치는 법: 결과물이 쓰일 장면과 그로 인해 내려질 결정을 한두 문장으로 적는다
- Before: 지난달 매출 데이터 분석해줘.
- After: 다음 주 영업 회의에서 하반기 프로모션 예산을 정하려고 해. 그 판단에 필요한 관점으로 지난달 매출 데이터를 분석해.

### R-CTX-002  규칙에 이유를 붙인다
- scope: common
- applies_to: instruction, user_prompt
- severity: medium
- status: active
- source: S-01
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: 이유 없는 금지·강제 문장. "~하지 마", "반드시 ~"만 있음
- 고치는 법: 규칙 뒤에 왜 그런지 한 문장을 붙인다. 모델이 규칙에 없는 상황까지 일반화한다
- Before: 말줄임표를 쓰지 마.
- After: 응답은 음성 합성으로 읽히므로 말줄임표를 쓰지 않는다. 엔진이 말줄임표를 발음하지 못한다.

### R-CTX-003  보고와 설명의 독자를 지정한다
- scope: common
- applies_to: instruction, user_prompt
- severity: medium
- status: active
- source: S-04
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: 보고서, 설명, 요약을 요청하는데 읽을 사람이 없음
- 고치는 법: 독자의 배경지식 수준과 읽고 나서 할 행동을 적는다
- Before: 이번 장애 원인 정리해줘.
- After: 개발 배경이 없는 운영팀장이 읽고 재발 방지 예산을 승인할 수 있도록 이번 장애 원인을 정리해.

### R-CTX-004  내부 용어와 약어를 정의한다
- scope: common
- applies_to: instruction, user_prompt
- severity: medium
- status: active
- source: S-01
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: 정의 없는 사내 약어, 시스템 이름, 팀 고유 표현
- 고치는 법: 맥락이 없는 신입이 읽어도 이해되도록 처음 나올 때 한 줄로 정의한다
- Before: OMS 기준으로 반품률 뽑아줘.
- After: OMS(주문 관리 시스템)의 주문 상태가 '반품 완료'인 건을 기준으로 반품률을 계산해.
