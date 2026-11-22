#!/bin/bash
# core/ 내용으로 adapters/generic/system-prompt.md를 다시 만든다.
# 사용법: 저장소 루트에서  bash adapters/generic/build.sh
set -euo pipefail
cd "$(dirname "$0")/../.."
OUT=adapters/generic/system-prompt.md
VERSION=$(cat VERSION 2>/dev/null || echo 0.0.0)
OLDEST=$(grep -rho '^- verified: [0-9-]*' core/rules core/vocabulary | awk '{print $3}' | sort | head -1)

{
  echo "# prompt-upgrader (붙여넣기용 v$VERSION)"
  echo
  echo "파일을 읽을 수 없는 AI 도구(ChatGPT, Gemini 웹 등)에서 쓰는 버전이다. 이 파일 전체를 시스템 프롬프트나 대화 첫 메시지로 붙여 넣은 뒤, review나 upgrade를 요청한다."
  echo "길이 때문에 규칙은 high severity만, 어휘는 표 요약만 들어 있다. 전체 규칙이 필요하면 Claude Code나 Codex 버전을 쓴다."
  echo "아래 본문에 나오는 파일 경로(core/...)는 이 붙여넣기 버전에서는 열 수 없다. 해당 내용은 이 문서 안의 절과 맨 아래 요약표를 대신 쓴다. refresh와 eval은 이 버전에서 지원하지 않는다."
  echo "core가 바뀌면 이 파일을 다시 생성한다. 생성 방법은 MAINTAINING.md 참고."
  echo
  echo "이 붙여넣기 버전의 규칙 기준일은 $OLDEST 이다. 결과 첫 줄은 항상 \`prompt-upgrader v$VERSION · 규칙 기준일 $OLDEST\` 로 쓴다. 오늘 날짜가 이 기준일보다 90일 넘게 지났으면 결과 끝에 \"재검증 필요: 규칙이 낡았을 수 있으니 최신 버전을 받으세요\"라고 쓴다."
  echo "아래 어휘 표에서 '(효과 작음)'이 붙은 항목은 기준 모델에서 효과가 작게 측정된 어휘다. 추천할 때 그 사실을 함께 알린다."
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
      /^## F-/ { if (id) print "| " id " | " title note " | " use " | " avoid " |"; id=$2; $1=""; $2=""; title=substr($0,3); note="" }
      /^- 쓸 때:/ { sub(/^- 쓸 때: /,""); use=$0 }
      /^- 쓰지 말 때:/ { sub(/^- 쓰지 말 때: /,""); avoid=$0 }
      /^- effect: none/ { note=" (효과 작음)" }
      END { if (id) print "| " id " | " title note " | " use " | " avoid " |" }
    ' "$f"
  done
  echo
  echo "## 정밀 어휘 요약"
  echo
  echo "| ID | 어휘 | 강한 표현 |"
  echo "|---|---|---|"
  for f in core/vocabulary/precision/*.md; do
    awk '
      /^## V-/ { if (id) print "| " id " | " title note " | " strong " |"; id=$2; $1=""; $2=""; title=substr($0,3); note="" }
      /^- 강한 표현:/ { sub(/^- 강한 표현: /,""); strong=$0 }
      /^- effect: none/ { note=" (효과 작음)" }
      END { if (id) print "| " id " | " title note " | " strong " |" }
    ' "$f"
  done
} > "$OUT"

echo "wrote $OUT ($(wc -l < "$OUT") lines)"
