#!/usr/bin/env bash
# sync-pull.sh — завантажити з репо в ~/.claude/
set -e

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "Синхронізація з $REPO_DIR → $CLAUDE_DIR"

# Skills
if [ -d "$REPO_DIR/.claude/skills" ]; then
  mkdir -p "$CLAUDE_DIR/skills"
  cp -r "$REPO_DIR/.claude/skills/." "$CLAUDE_DIR/skills/"
  echo "  skills: OK"
fi

# Agents
if [ -d "$REPO_DIR/agents" ]; then
  mkdir -p "$CLAUDE_DIR/agents"
  cp "$REPO_DIR/agents/"*.md "$CLAUDE_DIR/agents/"
  echo "  agents: OK"
fi

# Commands
if [ -d "$REPO_DIR/commands" ]; then
  mkdir -p "$CLAUDE_DIR/commands"
  cp "$REPO_DIR/commands/"*.md "$CLAUDE_DIR/commands/"
  echo "  commands: OK"
fi

echo "Готово."
