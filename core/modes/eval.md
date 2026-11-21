# eval 모드

스킬 폴더의 `evals/RUN.md` 절차를 따른다.

인자 처리:
- 인자 없음: cases와 effects를 모두 실행한다.
- `cases` 또는 `effects`: 해당 평가만 실행한다.
- `--model <모델ID>`: 결과 파일 이름과 기록에 쓸 모델 ID. 없으면 현재 실행 중인 모델 ID를 쓴다.

결과 파일 종류는 refresh에서 호출되면 refresh가 정한 값(`baseline` 또는 `after`), 사용자가 직접 실행하면 `manual`이다.

평가는 서브에이전트를 많이 띄운다 (전체 실행 시 약 50개). 실행 전에 사용자에게 범위와 대략적인 규모를 한 줄로 알린다.
