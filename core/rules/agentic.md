# 규칙: 에이전트 운영 (AGT)

여러 단계를 스스로 수행하는 에이전트의 위임, 보고, 범위, 누적된 지시를 다루는 규칙이다.

### R-AGT-001  위임은 병렬·독립 작업에만 하도록 기준을 둔다
- scope: claude
- applies_to: instruction
- severity: medium
- status: active
- source: S-01, S-04
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: "적극적으로 서브에이전트를 활용해", 위임 기준 없음. 근거 문서는 Opus 4.6과 Opus 5의 과잉 위임을 명시한다
- 고치는 법: 서로 독립적이고 동시에 돌릴 수 있는 작업만 위임하고, 짧은 작업은 직접 하라고 적는다
- Before: 복잡한 작업은 서브에이전트에게 적극적으로 맡겨.
- After: 서로 결과를 기다리지 않는 조사가 3개 이상일 때만 서브에이전트에 나눠 맡긴다. 파일 몇 개를 읽는 정도는 직접 한다.

### R-AGT-002  위임할 때 어떻게 브리핑할지 적는다
- scope: common
- applies_to: instruction
- severity: medium
- status: active
- source: S-04
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: 위임 도구가 있는데 하위 에이전트에게 무엇을 전달할지 지침이 없음
- 고치는 법: 하위 에이전트는 맥락이 없으므로 전달할 내용을 정한다. 목표, 범위, 완료 기준, 반환 형식을 권장한다
- Before: 조사는 하위 에이전트에게 맡겨.
- After: 하위 에이전트에게는 조사 목표, 볼 범위와 보지 않을 범위, 끝난 기준, 결과를 돌려줄 표 형식을 함께 전달한다.

### R-AGT-003  최종 보고는 맥락 없는 독자 기준으로 쓰게 한다
- scope: claude
- applies_to: instruction
- severity: medium
- status: active
- source: S-04
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: 작업 결과 보고나 인수인계 형식이 없음
- 고치는 법: 도구 호출 과정을 못 본, 똑똑하지만 맥락 없는 독자를 위해 결론, 근거, 남은 일 순으로 쓰게 한다
- Before: 끝나면 결과 알려줘.
- After: 끝나면 작업 과정을 보지 못한 사람도 이해하도록 결론, 바뀐 것, 확인하지 못한 것, 다음에 할 일 순서로 보고한다.

### R-AGT-004  요청 범위 밖의 기능·문서·리팩터링을 막는다
- scope: claude
- applies_to: instruction
- severity: medium
- status: active
- source: S-03
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: 코드나 문서를 수정하는 에이전트인데 변경 범위 지침이 없음
- 고치는 법: 요청받지 않은 기능, 문서, 리팩터링을 추가하지 말고, 발견한 것은 제안으로만 남기게 한다
- Before: 버그 고쳐줘.
- After: 보고된 버그만 고친다. 요청하지 않은 기능, 문서, 리팩터링은 추가하지 않는다. 고칠 만한 다른 문제를 발견하면 보고에 목록으로 남긴다.

### R-AGT-005  쌓인 낡은 지시와 과한 조심을 정리한다
- scope: claude
- applies_to: instruction
- severity: medium
- status: active
- source: S-04
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: "절대 재시도하지 마", 특정 사건 이후 붙인 경고, 서로 겹치거나 충돌하는 금지 문장의 누적
- 고치는 법: 더 이상 유효하지 않은 지시를 지우고, 남길 경고는 범위와 이유를 붙여 하나로 합친다
- Before: 재시도 금지. 다시 시도하지 말 것. 실패하면 멈춰. (지난 장애 때 추가)
- After: 같은 외부 API 호출이 2번 연속 실패하면 멈추고 보고한다. 일시적 네트워크 오류는 1번 다시 시도해도 된다.

### R-AGT-006  접근법을 정한 뒤 새 정보 없이 번복하지 않게 한다
- scope: claude
- applies_to: instruction
- severity: low
- status: active
- source: S-01
- verified: 2026-11-21 / claude-opus-5-5
- 검출 신호: 긴 작업 에이전트인데 방향 전환 기준이 없어 같은 결정을 반복해서 다시 검토함
- 고치는 법: 접근법을 하나 정해 진행하고, 그 판단을 뒤집는 새 정보가 나왔을 때만 바꾸게 한다
- Before: 가장 좋은 방법을 계속 고민하면서 진행해.
- After: 접근법을 하나 정해 끝까지 진행한다. 그 접근을 막는 새 사실이 확인됐을 때만 방향을 바꾸고, 바꾼 이유를 보고한다.
