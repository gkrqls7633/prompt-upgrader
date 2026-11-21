# 운영 가이드

이 스킬을 관리하는 사람을 위한 문서다. 규칙을 갱신하는 refresh, 평가만 돌리는 eval, 규칙과 어휘를 직접 추가하는 방법을 다룬다.

## 왜 갱신이 필요한가

프롬프트 모범 사례는 모델과 함께 바뀐다. 예를 들어 예전 모델에서는 `CRITICAL`, `MUST` 같은 강조가 지시를 지키게 했지만, 최신 모델에서는 오히려 과잉 행동을 부른다. 어떤 API 설정은 새 모델에서 오류가 된다. 오늘 맞는 규칙도 몇 달 뒤에는 낡은 규칙이 된다.

그래서 모든 규칙과 어휘에는 근거 문서와 마지막 검증일(`verified`)이 붙어 있다. 검증일이 90일을 넘은 항목이 쓰이면 결과 끝에 "재검증 필요"가 표시된다. 이 표시가 보이면 refresh할 때다.

## 언제 refresh하는가

- 분기마다 첫 주
- 새 모델이 출시됐을 때, 특히 회사가 쓰는 모델이 바뀔 때
- 평가 점수가 통과 기준 아래로 떨어졌을 때
- 결과 하단에 "재검증 필요"가 자주 보일 때

## refresh 런북

예상 소요 시간은 30~60분이고, 그중 사람이 개입하는 시간은 약 15분이다. 단계마다 담당을 표시했다.

### 0단계. 준비 [사람]

저장소로 이동한다.
```bash
cd ~/.claude/skills/prompt-upgrader
```
최신 상태로 맞춘다.
```bash
git checkout main && git pull
```
refresh용 브랜치를 만든다. 이름은 `refresh/<연도>-q<분기>` 또는 `refresh/<모델ID>` 형식이다.
```bash
git checkout -b refresh/2027-q1
```

### 1단계. refresh 시작 [사람 → 에이전트]

Claude Code에서 입력한다.
```text
/prompt-upgrader refresh
```
특정 모델 기준으로 돌릴 때:
```text
/prompt-upgrader refresh --model claude-opus-5-5
```
Codex나 Cursor처럼 슬래시 명령이 없는 도구에서는:
```text
core/modes/refresh.md 절차대로 refresh를 실행해줘. 기준 모델은 claude-opus-5-5야.
```
웹 문서를 읽어야 하므로 웹 접근이 되는 도구에서 실행한다.

### 2단계. 기준선 평가와 문서 대조 [에이전트]

에이전트가 다음을 하고 멈춘다. 이 단계에서는 규칙 파일이 바뀌지 않는다.
1. 현재 규칙으로 전체 평가 → `evals/results/<날짜>-<모델>-baseline.md`
2. `core/sources.md`의 문서를 다시 읽고 스냅샷과 비교
3. 변경안 작성 → `refresh/<날짜>-proposal.md`

### 3단계. 변경안 검토와 승인 [사람]

`refresh/<날짜>-proposal.md`를 열어 읽는다. 확인할 것:
- 근거로 인용된 문장이 실제 문서에 있는지 (링크를 열어 확인)
- 변경이 회사의 사용 방식과 충돌하지 않는지
- 폐기 대상 규칙이 회사 에이전트에서 아직 중요한지

채팅으로 항목별 결정을 보낸다.
```text
P-01, P-03 승인. P-02 보류.
```
- 승인: 반영한다.
- 보류: 이번에는 반영하지 않는다. 변경안 파일에 보류로 남고, 해당 항목의 검증일은 갱신되지 않아 경고가 계속 뜬다.
- 거절: 반영하지 않는다. 이유를 함께 적으면 변경안 파일에 기록된다. 예: `P-02 거절. 우리 상담봇은 이 프레임을 계속 쓴다.`
- 언급하지 않은 항목은 보류로 처리된다.

### 4단계. 적용과 재평가 [에이전트]

에이전트가 승인 항목만 반영하고, 평가를 다시 돌려 기준선과 비교표를 보여준다. 나빠진 지표가 있으면 원인 항목을 되돌리거나, 원인이 불분명하면 멈추고 보고한다.

비교표를 보고 판단한다. 다시 하고 싶으면 승인 메시지를 고쳐 다시 보낸다.

### 5단계. 확정 [사람 → 에이전트]

비교표에 문제가 없으면 입력한다.
```text
확정해줘
```
에이전트가 `VERSION`, `CHANGELOG.md`, `core/sources.md`의 스냅샷과 확인일, 각 항목의 `verified` 날짜를 갱신하고, 붙여넣기용 어댑터를 다시 만든다.

### 6단계. 커밋과 공유 [사람]

바뀐 파일을 확인한다.
```bash
git status
```
모두 스테이징한다.
```bash
git add -A
```
커밋한다. 메시지에 분기, 기준 모델, 새 버전을 넣는다.
```bash
git commit -m "refresh: 2027-Q1 (claude-opus-5-5) v1.1.0"
```
브랜치를 올린다.
```bash
git push -u origin refresh/2027-q1
```
GitHub에서 PR을 열어 main에 머지한다. 사내 사용자에게는 `CHANGELOG.md`의 해당 버전 항목을 공유한다. 사용자는 `git pull` 한 번으로 새 버전을 받는다.

### 중간에 멈췄을 때

- **2단계에서 멈춤**: 규칙 파일이 바뀌지 않았으므로 1단계 명령을 다시 실행한다.
- **4단계에서 멈춤**: 어디까지 반영됐는지 확인한다.
```bash
git diff --stat
```
처음부터 다시 하려면 반영 내용을 되돌리고, 3단계의 승인 메시지를 다시 보낸다.
```bash
git checkout -- core/
```

## 평가만 실행하기

규칙이나 어휘를 직접 고친 뒤, 또는 새 모델을 써보기 전에 실행한다. 전체 실행은 서브에이전트 약 50개를 띄우므로 시간과 비용이 든다.

```text
/prompt-upgrader eval
/prompt-upgrader eval cases
/prompt-upgrader eval effects --model claude-haiku-5-5
```

결과는 `evals/results/<날짜>-<모델>-manual.md`에 저장된다. 통과 기준은 `evals/RUN.md`에 있다.

## 버전 규칙

| 변경 | 버전 | 예 |
|---|---|---|
| MAJOR | 호환이 깨짐 | 모드 추가·삭제, 출력 형식이나 채점 구조 변경 |
| MINOR | 내용 추가·수정 | 규칙이나 어휘의 추가·수정, 평가 케이스 추가 |
| PATCH | 다듬기 | 문구 수정, `verified` 날짜 갱신 |

## 규칙이나 어휘를 직접 추가할 때

1. 같은 카테고리 파일에 기존 항목과 같은 형식으로 추가한다. ID는 그 카테고리의 다음 번호다.
   - 규칙: 필드 10개 (`scope`, `applies_to`, `severity`, `status`, `source`, `verified`, `검출 신호`, `고치는 법`, `Before`, `After`)
   - 정밀 어휘: 필드 7개 (`상황`, `약한 표현`, `강한 표현`, `효과가 있는 이유`, `업무 예시`, `관련 규칙`, `verified`)
   - 프레임 어휘: 필드 11개 (`의도`, `바뀌는 태도`, `쓸 때`, `쓰지 말 때`, `대안`, `함께 쓸 정밀 어휘`, `템플릿`, `Before`, `After`, `효과 평가`, `verified`)
2. 근거 문서가 `core/sources.md`에 없으면 새 출처(`S-NN`)를 추가하고 스냅샷을 쓴다.
3. 구조를 검사한다. 아래 명령은 출력이 없어야 통과다.

규칙의 필드 수:
```bash
for f in core/rules/*.md; do awk -v f="$f" '/^### R-/{if(id)print f, id, n; id=$2; n=0} /^- (scope|applies_to|severity|status|source|verified|검출 신호|고치는 법|Before|After):/{n++} END{if(id)print f, id, n}' "$f"; done | awk '$3!=10'
```
ID 중복:
```bash
grep -rho '^#\{2,3\} [RVF]-[A-Z]*-[0-9]*' core/ | sort | uniq -d
```
출처 참조:
```bash
comm -23 <(grep -ho 'S-[0-9][0-9]' core/rules/*.md | sort -u) <(grep -o '^## S-[0-9][0-9]' core/sources.md | grep -o 'S-[0-9]*' | sort -u)
```
정밀 어휘의 필드 수:
```bash
for f in core/vocabulary/precision/*.md; do awk -v f="$f" '/^## V-/{if(id)print f, id, n; id=$2; n=0} /^- (상황|약한 표현|강한 표현|효과가 있는 이유|업무 예시|관련 규칙|verified):/{n++} END{if(id)print f, id, n}' "$f"; done | awk '$3!=7'
```
4. 새 규칙을 검증할 평가 케이스가 없으면 `evals/cases/`에 추가한다.
5. `/prompt-upgrader eval`로 통과를 확인한다.
6. `VERSION`을 MINOR로 올리고 `CHANGELOG.md`에 기록한다.
7. 붙여넣기용 어댑터를 다시 만든다 (아래).

## 붙여넣기용 어댑터 다시 만들기

`adapters/generic/system-prompt.md`는 파일을 읽을 수 없는 도구(ChatGPT 웹 등)용으로 `core/`를 이어 붙인 파일이다. `core/`가 바뀌면 다시 만든다.
```bash
bash adapters/generic/build.sh
```
구성: PROTOCOL, 채점 기준, review·upgrade 절차, high severity 규칙 표, 프레임 어휘 표, 정밀 어휘 표.

## 규칙 폐기

삭제하지 않고 상태를 바꾼다. 이미 이 규칙 ID를 참조하는 결과나 문서가 있기 때문이다.
```markdown
- status: deprecated
- deprecated_reason: 2027-01 Claude 6 계열부터 강조어 과잉 반응이 사라짐 (S-01 변경)
- replaced_by: (대체 규칙 ID, 없으면 생략)
```
폐기된 규칙은 적용되지 않는다. 다음 MAJOR 버전에서 파일에서 지운다.
