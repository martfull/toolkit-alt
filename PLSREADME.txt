================================================================
  toolkit-alt — ПОВНА ІНСТРУКЦІЯ ПО ВИКОРИСТАННЮ
================================================================

Репо: https://github.com/martfull/toolkit-alt

----------------------------------------------------------------
  СТРУКТУРА РЕПО
----------------------------------------------------------------

  .claude/skills/   — skills  (тригеряться через /skill <name>)
  agents/           — agents  (~/.claude/agents/)
  commands/         — команди (~/.claude/commands/)
  scripts/
    install.sh      — вибіркова установка без клонування
    sync-pull.sh    — завантажити все з GitHub → ~/.claude/
    sync-push.sh    — вивантажити все з ~/.claude/ → GitHub

----------------------------------------------------------------
  ШВИДКИЙ СТАРТ — НОВИЙ ПРИСТРІЙ
----------------------------------------------------------------

Варіант А: без клонування (рекомендовано)
------------------------------------------
Переглянути що є в репо:

  bash <(curl -s https://raw.githubusercontent.com/martfull/toolkit-alt/main/scripts/install.sh) list

Встановити вибране:

  bash <(curl -s https://raw.githubusercontent.com/martfull/toolkit-alt/main/scripts/install.sh) skill img
  bash <(curl -s https://raw.githubusercontent.com/martfull/toolkit-alt/main/scripts/install.sh) agent termux-docs
  bash <(curl -s https://raw.githubusercontent.com/martfull/toolkit-alt/main/scripts/install.sh) all

Варіант Б: з клонуванням
--------------------------
  git clone https://github.com/martfull/toolkit-alt.git ~/toolkit-alt
  cd ~/toolkit-alt
  chmod +x scripts/*.sh

  # Встановити все одразу
  ./scripts/sync-pull.sh

  # Або вибірково
  ./scripts/install.sh skill img
  ./scripts/install.sh agent termux-docs

----------------------------------------------------------------
  install.sh — ВИБІРКОВА УСТАНОВКА
----------------------------------------------------------------

  install.sh list              — показати все доступне в репо
  install.sh skill <name>      — встановити конкретний skill
  install.sh agent <name>      — встановити конкретний agent
  install.sh command <name>    — встановити конкретну команду
  install.sh all               — встановити все

Файли копіюються напряму в ~/.claude/ через GitHub API.
Клонувати репо не потрібно.

----------------------------------------------------------------
  sync-push.sh — ЗБЕРЕГТИ ЗМІНИ В GITHUB
----------------------------------------------------------------

Коли додав нові skills/agents або відредагував існуючі:

  cd ~/toolkit-alt
  ./scripts/sync-push.sh

Скрипт сам:
  1. Копіює ~/.claude/skills/, ~/.claude/agents/, ~/.claude/commands/ в репо
  2. Робить git commit
  3. Пушить на GitHub

----------------------------------------------------------------
  sync-pull.sh — ОНОВИТИ З GITHUB
----------------------------------------------------------------

Коли хочеш отримати зміни з репо на поточному пристрої:

  cd ~/toolkit-alt
  git pull
  ./scripts/sync-pull.sh

----------------------------------------------------------------
  ДОДАТИ НОВИЙ SKILL / AGENT / COMMAND
----------------------------------------------------------------

1. Створи файл у ~/.claude/:
     Skill   → ~/.claude/skills/<name>/SKILL.md
     Agent   → ~/.claude/agents/<name>.md
     Command → ~/.claude/commands/<name>.md

2. Збери в репо і запуши:
     cd ~/toolkit-alt && ./scripts/sync-push.sh

3. На інших пристроях підтягни:
     bash <(curl -s https://raw.githubusercontent.com/martfull/toolkit-alt/main/scripts/install.sh) skill <name>

----------------------------------------------------------------
  ВМІСТ РЕПО
----------------------------------------------------------------

Skills:
  img          /skill img або /img    Аналіз зображень з галереї

Agents:
  claude-code-docs                    Документація по Claude Code CLI
  termux-docs                         Документація Termux

Commands:
  img          /img                   Команда для роботи із зображеннями

----------------------------------------------------------------
  ПІДКАЗКИ
----------------------------------------------------------------

Різниця між типами:
  skill   — спеціалізована поведінка, тригериться явно (/skill <name>)
  agent   — субагент якого Claude запускає автоматично за контекстом
  command — slash-команда /name, швидкий ярлик для частих дій

Перевірити що встановлено локально:
  ls ~/.claude/skills/ ~/.claude/agents/ ~/.claude/commands/

================================================================
