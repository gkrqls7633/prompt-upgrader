# 근거 문서

규칙과 어휘의 근거가 되는 문서 목록이다. refresh는 이 파일의 스냅샷과 현재 문서를 비교해 변화를 찾는다.
스냅샷은 문서의 핵심 주장을 짧게 요약하고, 그 주장에 기대는 규칙 ID를 화살표로 잇는다.

## S-01  Claude prompting best practices
- url: https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-prompting-best-practices.md
- scope: claude (일반 원칙 부분은 common 규칙의 근거로도 쓴다)
- 근거로 쓰는 규칙: R-CLR-001~004, R-CTX-001, R-CTX-002, R-CTX-004, R-STR-001~005, R-EMP-001, R-EMP-003, R-OUT-001~003, R-TOL-001~004, R-BND-003, R-BND-004, R-CMP-001, R-AGT-001, R-AGT-006, R-FIT-001~004, R-LEG-001, R-LEG-002
- last_checked: 2026-11-21
- 핵심 주장 스냅샷:
  - 질문형 요청은 제안만 돌아올 때가 있고, 명령형은 실제 변경으로 이어진다 → R-CLR-001
  - 맥락 없는 신입 직원처럼 대하고, 지시의 이유를 설명하면 일반화한다 → R-CTX-002, R-CTX-004
  - XML 태그, 예시 3~5개, 긴 자료는 위에 질문은 끝에(최대 30% 개선) → R-STR-001~004
  - Opus 4.5/4.6은 "CRITICAL: You MUST" 같은 강한 문구에 과잉 반응한다 → R-EMP-001, R-TOL-003
  - "If in doubt, use [tool]"은 과잉 호출을 부른다 → R-TOL-002
  - budget_tokens는 4.7 이후 400, 마지막 assistant 턴 prefill은 4.6 이후 400 → R-LEG-001, R-LEG-002
  - Opus 4.6과 Opus 5는 서브에이전트를 과하게 쓰는 경향이 있다 → R-AGT-001
  - 돈이 오가는 도구는 사람이 매 호출을 승인한다 → R-BND-004

## S-02  Prompt engineering overview
- url: https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/overview.md
- scope: common
- 근거로 쓰는 규칙: 평가 체계 전반 (evals/, MAINTAINING.md)
- last_checked: 2026-11-21
- 핵심 주장 스냅샷:
  - 프롬프트 엔지니어링 전에 성공 기준, 경험적 테스트 방법, 초안 프롬프트가 있어야 한다 → evals/
  - 기법의 최신 기준은 best practices 문서다 → S-01을 주 근거로 삼는 이유
  - 예전 튜토리얼은 Claude 3 기준이며, 차이가 있으면 best practices를 따른다

## S-03  Prompting Claude Haiku 5.5
- url: https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-haiku-5-5.md
- scope: claude
- 근거로 쓰는 규칙: R-TOL-006, R-CMP-002, R-CMP-003, R-CMP-004, R-AGT-004, R-LEG-002, R-LEG-004
- last_checked: 2026-11-21
- 핵심 주장 스냅샷:
  - effort가 사고량의 주 조절 수단이고 budget_tokens는 400 → R-LEG-002
  - 검색 도구를 주면 오늘 날짜도 주고, 포괄적 "무조건 검색" 지시는 피한다 → R-TOL-006
  - 코딩 에이전트는 완료 보고 전에 실제 검사를 돌리고, 못 돌린 것은 이유와 함께 말한다 → R-CMP-002, R-CMP-003
  - "요청받은 일이 다 끝날 때까지 계속한다", "요청하지 않은 기능·문서·리팩터링은 추가하지 않는다" → R-CMP-004, R-AGT-004
  - 응답 안에 사고 과정을 쓰라고 하면 reasoning_extraction 거절이 날 수 있다 → R-LEG-004

## S-04  Prompting Claude Fable 5.2
- url: https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-fable-5-2.md
- scope: claude
- 근거로 쓰는 규칙: R-CTX-003, R-EMP-002, R-TOL-005, R-BND-001, R-BND-002, R-CMP-004, R-AGT-002, R-AGT-003, R-AGT-005, R-LEG-003, R-LEG-005
- last_checked: 2026-11-21
- 핵심 주장 스냅샷:
  - effort 기본값은 high, "숙고하지 말고 바로 답해"는 medium 이상에서 사고를 줄이지 못한다 → R-LEG-003
  - 작업 완수 블록이 낮은 effort의 조기 중단을 막는다 → R-CMP-004
  - "never"가 들어간 지시는 절대 규칙으로 취급된다. 범위와 예외를 명시한다 → R-EMP-002
  - 승인이 필요한 행동은 구체적으로, 스스로 해도 되는 일상 단계는 목록으로 → R-BND-001, R-BND-002
  - 서브에이전트 도구 설명에 비용과 위임할 가치가 있는 경우를 쓰면 호출이 약 절반으로 줄었다 → R-TOL-005, R-AGT-002
  - 최종 보고는 똑똑하지만 맥락이 없는 독자를 위해 쓴다 → R-AGT-003, R-CTX-003
  - 더 이상 유효하지 않은 메모·노트의 지시는 지운다 → R-AGT-005
  - 큰 토큰 예산 문구를 없애도 성능은 같고 비용은 줄었다 → R-LEG-005
