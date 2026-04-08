#!/usr/bin/env bash
# sync-push.sh — вивантажити з ~/.claude/ в репо і запушити
set -e

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "Синхронізація з $CLAUDE_DIR → $REPO_DIR"

# Skills
if [ -d "$CLAUDE_DIR/skills" ]; then
  mkdir -p "$REPO_DIR/.claude/skills"
  cp -r "$CLAUDE_DIR/skills/." "$REPO_DIR/.claude/skills/"
  echo "  skills: OK"
fi

# Agents
if [ -d "$CLAUDE_DIR/agents" ]; then
  mkdir -p "$REPO_DIR/agents"
  cp "$CLAUDE_DIR/agents/"*.md "$REPO_DIR/agents/"
  echo "  agents: OK"
fi

# Commands
if [ -d "$CLAUDE_DIR/commands" ]; then
  mkdir -p "$REPO_DIR/commands"
  cp "$CLAUDE_DIR/commands/"*.md "$REPO_DIR/commands/"
  echo "  commands: OK"
fi

cd "$REPO_DIR"
git add -A
git diff --cached --quiet && echo "Нічого нового." && exit 0
git commit -m "sync: оновлення skills/agents/commands"
git push origin main
echo "Запушено."
