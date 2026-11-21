#!/bin/bash
# core/ 내용으로 adapters/generic/system-prompt.md를 다시 만든다.
# 사용법: 저장소 루트에서  bash adapters/generic/build.sh
set -euo pipefail
cd "$(dirname "$0")/../.."
OUT=adapters/generic/system-prompt.md
VERSION=$(cat VERSION 2>/dev/null || echo 0.0.0)

{
  echo "# prompt-upgrader (붙여넣기용 v$VERSION)"
  echo
  echo "파일을 읽을 수 없는 AI 도구(ChatGPT, Gemini 웹 등)에서 쓰는 버전이다. 이 파일 전체를 시스템 프롬프트나 대화 첫 메시지로 붙여 넣은 뒤, review나 upgrade를 요청한다."
  echo "길이 때문에 규칙은 high severity만, 어휘는 표 요약만 들어 있다. 전체 규칙이 필요하면 Claude Code나 Codex 버전을 쓴다."
  echo "아래 본문에 나오는 파일 경로(core/...)는 이 붙여넣기 버전에서는 열 수 없다. 해당 내용은 이 문서 안의 절과 맨 아래 요약표를 대신 쓴다. refresh와 eval은 이 버전에서 지원하지 않는다."
  echo "core가 바뀌면 이 파일을 다시 생성한다. 생성 방법은 MAINTAINING.md 참고."
  echo
  echo "---"
  echo
  sed 's/^# /## /' core/PROTOCOL.md
  echo
  sed 's/^# /## /' core/rubric.md
  echo
  sed 's/^# /## /' core/modes/review.md
  echo
  sed 's/^# /## /' core/modes/upgrade.md
  echo
  echo "## 규칙 요약 (high severity)"
  echo
  echo "| ID | 규칙 | scope | 고치는 법 |"
  echo "|---|---|---|---|"
  for f in core/rules/*.md; do
    awk '
      /^### R-/ { id=$2; $1=""; $2=""; title=substr($0,3); sev=""; sc=""; fix="" }
      /^- scope:/ { sc=$3 }
      /^- severity:/ { sev=$3 }
      /^- 고치는 법:/ { sub(/^- 고치는 법: /,""); fix=$0; if (sev=="high") print "| " id " | " title " | " sc " | " fix " |" }
    ' "$f"
  done
  echo
  echo "## 프레임 어휘 요약"
  echo
  echo "| ID | 프레임 | 쓸 때 | 쓰지 말 때 |"
  echo "|---|---|---|---|"
  for f in core/vocabulary/frames/*.md; do
    awk '
      /^## F-/ { id=$2; $1=""; $2=""; title=substr($0,3) }
      /^- 쓸 때:/ { sub(/^- 쓸 때: /,""); use=$0 }
      /^- 쓰지 말 때:/ { sub(/^- 쓰지 말 때: /,""); print "| " id " | " title " | " use " | " $0 " |" }
    ' "$f"
  done
  echo
  echo "## 정밀 어휘 요약"
  echo
  echo "| ID | 어휘 | 강한 표현 |"
  echo "|---|---|---|"
  for f in core/vocabulary/precision/*.md; do
    awk '
      /^## V-/ { id=$2; $1=""; $2=""; title=substr($0,3) }
      /^- 강한 표현:/ { sub(/^- 강한 표현: /,""); print "| " id " | " title " | " $0 " |" }
    ' "$f"
  done
} > "$OUT"

echo "wrote $OUT ($(wc -l < "$OUT") lines)"
