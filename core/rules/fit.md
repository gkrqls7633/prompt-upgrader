# 규칙: 역할 적합성 (FIT)

지침이 그 에이전트의 담당 업무와 보유 도구·스킬에 맞게 쓰였는지 대조하는 규칙이다. review 모드에서만 쓴다.

도구 목록이나 담당 업무가 제공되지 않으면 R-FIT-002, R-FIT-003은 감점하지 않고
"도구 목록 미제공. 제공하면 정확도가 올라간다"라고 표시한다.

### R-FIT-001  지침이 담당 업무 범위를 정의한다
- scope: common
- applies_to: instruction
- severity: high
- status: active
- source: S-01
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: 무엇을 하는 에이전트인지, 무엇은 하지 않는지 불분명함
- 고치는 법: 담당 업무와 범위 밖 업무를 각각 한두 문장으로 적고, 범위 밖 요청을 받으면 어떻게 할지 적는다
- Before: 너는 유능한 사내 도우미야.
- After: 너는 인사팀 규정 안내 에이전트다. 휴가, 복리후생, 근태 규정 질문에 답한다. 급여 계산이나 개인 인사 정보 조회는 하지 않고 인사팀 메일 주소를 안내한다.

### R-FIT-002  지침이 언급한 도구와 실제 보유 도구가 일치한다
- scope: common
- applies_to: instruction
- severity: high
- status: active
- source: S-01
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: 보유하지 않은 도구를 언급함, 도구 이름이 실제와 다름
- 고치는 법: 실제 보유 도구 목록과 이름을 맞추고, 없는 도구를 언급한 문장은 지우거나 대체 방법을 적는다
- Before: (보유 도구: search_policy) 지침: "calendar 도구로 휴가 일정을 등록해"
- After: 휴가 등록은 직접 할 수 없다. search_policy로 신청 절차를 찾아 안내하고, 신청은 사용자가 인사 시스템에서 하도록 안내한다.

### R-FIT-003  보유 도구마다 사용 지침이 있다
- scope: common
- applies_to: instruction
- severity: medium
- status: active
- source: S-01
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: 보유 도구 중 지침에 한 번도 나오지 않는 도구가 있음
- 고치는 법: 빠진 도구마다 쓸 때와 쓰지 않을 때를 한 줄씩 추가한다 (R-TOL-001과 함께 본다)
- Before: (보유 도구: search_policy, create_ticket) 지침에는 search_policy만 설명
- After: create_ticket: 규정으로 해결되지 않아 담당자 확인이 필요한 문의일 때 쓴다. 단순 안내로 끝나는 질문에는 쓰지 않는다.

### R-FIT-004  역할은 한 문장으로, 전문성은 판단 기준으로 쓴다
- scope: common
- applies_to: instruction
- severity: medium
- status: active
- source: S-01
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: "세계 최고의", "20년 경력의" 같은 수식만 있고 판단 기준이 없음
- 고치는 법: 역할은 한 문장이면 충분하다. 전문가다움은 그 분야에서 좋은 결과와 나쁜 결과를 가르는 기준과 흔한 함정으로 쓴다
- Before: 너는 세계 최고 수준의 20년 경력 시니어 코드 리뷰어다.
- After: 너는 이 저장소의 코드 리뷰어다. 리뷰 우선순위는 정확성, 보안, 성능, 가독성 순이다. 스타일 지적은 린터가 잡지 못하는 것만 한다.
