# 규칙: 경계와 승인 (BND)

에이전트가 혼자 해도 되는 일과 확인받아야 할 일을 구분하는 규칙이다.

### R-BND-001  승인이 필요한 작업을 구체적으로 적는다
- scope: common
- applies_to: instruction
- severity: high
- status: active
- source: S-04
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: "중요한 작업은 확인받아", "위험한 건 물어봐"처럼 대상이 모호함
- 고치는 법: 확인받을 행동을 동사와 대상으로 적는다. 모호한 승인 목록은 일상 작업까지 멈추게 한다
- Before: 중요한 변경은 먼저 확인받아.
- After: 운영 DB에 쓰기 쿼리를 실행하기 전, 그리고 외부 고객에게 메일을 보내기 전에는 확인을 받는다.

### R-BND-002  승인 없이 해도 되는 일상 작업을 적는다
- scope: claude
- applies_to: instruction
- severity: medium
- status: active
- source: S-04
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: 승인 목록만 있고 허용 목록이 없음, 에이전트가 사소한 일마다 질문함
- 고치는 법: 확인 없이 진행해도 되는 일상 단계를 목록으로 적는다
- Before: 확실하지 않으면 물어봐.
- After: 파일 읽기, 읽기 전용 쿼리, 테스트 실행, 초안 작성은 확인 없이 진행한다.

### R-BND-003  되돌릴 수 없는 작업은 확인하고 검사 우회를 금한다
- scope: common
- applies_to: instruction
- severity: high
- status: active
- source: S-01
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: 삭제, 배포, 강제 푸시 권한이 있는데 확인 지침이 없음. 검사 생략을 허용함
- 고치는 법: 되돌릴 수 없는 작업 앞에서 확인을 받고, 검사를 건너뛰는 옵션(--no-verify 등)을 쓰지 않게 한다
- Before: 배포까지 알아서 진행해.
- After: 스테이징 배포까지는 진행한다. 운영 배포와 데이터 삭제는 확인을 받는다. 커밋 훅이나 테스트를 건너뛰는 옵션은 쓰지 않는다.

### R-BND-004  돈이 오가는 작업은 프롬프트가 아닌 사람 승인으로 막는다
- scope: common
- applies_to: instruction
- severity: high
- status: active
- source: S-01
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: 결제, 환불, 송금 도구가 있는데 제한이 프롬프트 문장뿐임
- 고치는 법: 지침은 행동을 안내할 뿐 강제하지 못한다. 돈이 오가는 도구 호출은 시스템에서 사람이 매번 승인하게 하고, 지침에도 그 사실을 적는다
- Before: 환불은 10만 원 이하만 처리해.
- After: 환불 도구는 호출할 때마다 담당자 승인 화면을 거친다. 승인 요청에는 주문번호, 금액, 환불 사유를 적는다.
