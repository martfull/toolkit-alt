#!/usr/bin/env bash
# install.sh — вибіркова установка skills/agents/commands з GitHub
# Використання:
#   ./install.sh list                    — показати все доступне
#   ./install.sh skill img               — встановити конкретний skill
#   ./install.sh agent termux-docs       — встановити конкретний agent
#   ./install.sh command img             — встановити конкретну команду
#   ./install.sh all                     — встановити все
#
# Або без клонування репо:
#   bash <(curl -s https://raw.githubusercontent.com/martfull/toolkit-alt/main/scripts/install.sh) list

set -e

REPO="martfull/toolkit-alt"
BRANCH="main"
CLAUDE_DIR="${CLAUDE_DIR:-$HOME/.claude}"
API="https://api.github.com/repos/$REPO/contents"
RAW="https://raw.githubusercontent.com/$REPO/$BRANCH"

# Кольори
GREEN="\033[32m"; YELLOW="\033[33m"; BLUE="\033[34m"; RED="\033[31m"; RESET="\033[0m"
ok()   { echo -e "${GREEN}  ✓${RESET} $*"; }
info() { echo -e "${BLUE}  →${RESET} $*"; }
warn() { echo -e "${YELLOW}  !${RESET} $*"; }
err()  { echo -e "${RED}  ✗${RESET} $*"; exit 1; }

# Отримати список файлів/папок через GitHub API
gh_ls() {
  local path="$1"
  curl -s "$API/$path?ref=$BRANCH" | python3 -c "
import sys, json
data = json.load(sys.stdin)
if isinstance(data, list):
    for x in data: print(x['type'], x['name'], x['path'])
"
}

# Завантажити один файл
download_file() {
  local remote_path="$1"
  local local_path="$2"
  mkdir -p "$(dirname "$local_path")"
  curl -sf "$RAW/$remote_path" -o "$local_path" || err "Не вдалось завантажити: $remote_path"
}

# Рекурсивно завантажити директорію
download_dir() {
  local remote_path="$1"
  local local_base="$2"
  gh_ls "$remote_path" | while read -r type name path; do
    if [ "$type" = "file" ]; then
      local dest="$local_base/$name"
      download_file "$path" "$dest"
      ok "$dest"
    elif [ "$type" = "dir" ]; then
      download_dir "$path" "$local_base/$name"
    fi
  done
}

# Показати доступне
cmd_list() {
  echo -e "\n${BLUE}=== Skills ===${RESET}"
  gh_ls ".claude/skills" | awk '{print "  /skill", $2}'

  echo -e "\n${BLUE}=== Agents ===${RESET}"
  gh_ls "agents" | awk '{gsub(/\.md$/,"",$2); print "  agent:", $2}'

  echo -e "\n${BLUE}=== Commands ===${RESET}"
  gh_ls "commands" | awk '{gsub(/\.md$/,"",$2); print "  /", $2}'
  echo ""
}

# Встановити skill
cmd_skill() {
  local name="$1"
  [ -z "$name" ] && err "Вкажи назву: install.sh skill <name>"
  local dest="$CLAUDE_DIR/skills/$name"
  info "Встановлення skill: $name → $dest"
  # Перевірити чи існує
  gh_ls ".claude/skills/$name" > /dev/null 2>&1 || err "Skill '$name' не знайдено. Перевір: ./install.sh list"
  download_dir ".claude/skills/$name" "$dest"
  ok "Skill '$name' встановлено"
}

# Встановити agent
cmd_agent() {
  local name="$1"
  [ -z "$name" ] && err "Вкажи назву: install.sh agent <name>"
  # Спробувати з .md і без
  local file="agents/${name}.md"
  local dest="$CLAUDE_DIR/agents/${name}.md"
  info "Встановлення agent: $name → $dest"
  download_file "$file" "$dest"
  ok "Agent '$name' встановлено"
}

# Встановити command
cmd_command() {
  local name="$1"
  [ -z "$name" ] && err "Вкажи назву: install.sh command <name>"
  local file="commands/${name}.md"
  local dest="$CLAUDE_DIR/commands/${name}.md"
  info "Встановлення command: $name → $dest"
  download_file "$file" "$dest"
  ok "Command '$name' встановлено"
}

# Встановити все
cmd_all() {
  info "Встановлення всього..."

  echo "Skills:"
  gh_ls ".claude/skills" | while read -r type name path; do
    [ "$type" = "dir" ] && cmd_skill "$name"
  done

  echo "Agents:"
  gh_ls "agents" | while read -r type name path; do
    [ "$type" = "file" ] && cmd_agent "${name%.md}"
  done

  echo "Commands:"
  gh_ls "commands" | while read -r type name path; do
    [ "$type" = "file" ] && cmd_command "${name%.md}"
  done

  ok "Готово!"
}

# --- Точка входу ---
case "${1:-}" in
  list)              cmd_list ;;
  skill)             cmd_skill "$2" ;;
  agent)             cmd_agent "$2" ;;
  command|cmd)       cmd_command "$2" ;;
  all)               cmd_all ;;
  *)
    echo -e "Використання:"
    echo -e "  ${GREEN}install.sh list${RESET}              — показати доступне"
    echo -e "  ${GREEN}install.sh skill <name>${RESET}      — встановити skill"
    echo -e "  ${GREEN}install.sh agent <name>${RESET}      — встановити agent"
    echo -e "  ${GREEN}install.sh command <name>${RESET}    — встановити команду"
    echo -e "  ${GREEN}install.sh all${RESET}               — встановити все"
    echo ""
    echo -e "Без клонування репо:"
    echo -e "  ${YELLOW}bash <(curl -s https://raw.githubusercontent.com/$REPO/$BRANCH/scripts/install.sh) list${RESET}"
    ;;
esac
