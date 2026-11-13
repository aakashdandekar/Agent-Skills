#!/usr/bin/env bash
# Install video-generation skill across Antigravity, Claude Code, Codex, and OpenCode
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_SOURCE="${SCRIPT_DIR}/skills/video-generation"

TARGET_DIRS=(
  "$HOME/.gemini/config/skills"
  "$HOME/.claude/skills"
  "$HOME/.codex/skills"
  "$HOME/.config/opencode/skills"
)

if [[ ! -f "${SKILL_SOURCE}/SKILL.md" ]]; then
  echo "Error: SKILL.md not found at ${SKILL_SOURCE}/SKILL.md" >&2
  exit 1
fi

for dir in "${TARGET_DIRS[@]}"; do
  mkdir -p "$dir"
  ln -sfn "$SKILL_SOURCE" "${dir}/video-generation"
  echo "Linked video-generation -> ${dir}/video-generation"
done

echo ""
echo "Installation successful! The 'video-generation' skill is now active."
