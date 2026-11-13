#!/usr/bin/env bash
# Install skills from Agent-Skills across Antigravity, Claude Code, Codex, and OpenCode
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="${SCRIPT_DIR}/skills"

TARGET_DIRS=(
  "$HOME/.gemini/config/skills"
  "$HOME/.claude/skills"
  "$HOME/.codex/skills"
  "$HOME/.config/opencode/skills"
)

# Ensure target directories exist
for dir in "${TARGET_DIRS[@]}"; do
  mkdir -p "$dir"
done

# If an argument is provided, install only that skill; otherwise install all
SKILL_TARGET="${1:-all}"

found=0
for skill_path in "${SKILLS_DIR}"/*/; do
  if [[ -f "${skill_path}SKILL.md" ]]; then
    skill_name="$(basename "$skill_path")"
    if [[ "$SKILL_TARGET" == "all" || "$SKILL_TARGET" == "$skill_name" ]]; then
      found=1
      for target_dir in "${TARGET_DIRS[@]}"; do
        ln -sfn "$skill_path" "${target_dir}/${skill_name}"
        echo "Linked ${skill_name} -> ${target_dir}/${skill_name}"
      done
    fi
  fi
done

if [[ "$found" -eq 0 ]]; then
  echo "Error: Skill '${SKILL_TARGET}' not found in ${SKILLS_DIR}" >&2
  exit 1
fi

echo ""
echo "Installation complete!"
