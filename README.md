# toolkit-alt

Claude Code agents, skills & commands — синхронізація між пристроями.

---

## Структура репо

```
.claude/skills/   — skills  (тригеряться через /skill <name>)
agents/           — agents  (~/.claude/agents/)
commands/         — команди (~/.claude/commands/)
scripts/
  install.sh      — вибіркова установка без клонування
  sync-pull.sh    — завантажити все з GitHub → ~/.claude/
  sync-push.sh    — вивантажити все з ~/.claude/ → GitHub
```

---

## Швидкий старт — новий пристрій

### Варіант А: без клонування (рекомендовано)

Переглянути що є в репо:
```bash
bash <(curl -s https://raw.githubusercontent.com/martfull/toolkit-alt/main/scripts/install.sh) list
```

Встановити вибране:
```bash
bash <(curl -s https://raw.githubusercontent.com/martfull/toolkit-alt/main/scripts/install.sh) skill img
bash <(curl -s https://raw.githubusercontent.com/martfull/toolkit-alt/main/scripts/install.sh) agent termux-docs
bash <(curl -s https://raw.githubusercontent.com/martfull/toolkit-alt/main/scripts/install.sh) all
```

### Варіант Б: з клонуванням

```bash
git clone https://github.com/martfull/toolkit-alt.git ~/toolkit-alt
cd ~/toolkit-alt
chmod +x scripts/*.sh

# Встановити все одразу
./scripts/sync-pull.sh

# Або вибірково
./scripts/install.sh skill img
./scripts/install.sh agent termux-docs
```

---

## install.sh — вибіркова установка

| Команда | Що робить |
|---------|-----------|
| `install.sh list` | Показати все доступне в репо |
| `install.sh skill <name>` | Встановити конкретний skill |
| `install.sh agent <name>` | Встановити конкретний agent |
| `install.sh command <name>` | Встановити конкретну команду |
| `install.sh all` | Встановити все |

Файли копіюються напряму в `~/.claude/` через GitHub API — репо клонувати не потрібно.

---

## sync-push.sh — зберегти зміни в GitHub

Коли додав нові skills/agents або відредагував існуючі:

```bash
cd ~/toolkit-alt
./scripts/sync-push.sh
```

Скрипт сам:
1. Копіює `~/.claude/skills/`, `~/.claude/agents/`, `~/.claude/commands/` в репо
2. Робить `git commit`
3. Пушить на GitHub

---

## sync-pull.sh — оновити з GitHub

Коли хочеш отримати зміни з репо на поточному пристрої:

```bash
cd ~/toolkit-alt
git pull
./scripts/sync-pull.sh
```

---

## Додати новий skill / agent / command

1. Створи файл у `~/.claude/`:
   - Skill → `~/.claude/skills/<name>/SKILL.md`
   - Agent → `~/.claude/agents/<name>.md`
   - Command → `~/.claude/commands/<name>.md`

2. Збери в репо і запуши:
   ```bash
   cd ~/toolkit-alt && ./scripts/sync-push.sh
   ```

3. На інших пристроях підтягни:
   ```bash
   bash <(curl -s https://raw.githubusercontent.com/martfull/toolkit-alt/main/scripts/install.sh) skill <name>
   ```

---

## Вміст

### Skills
| Назва | Як викликати | Опис |
|-------|-------------|------|
| `img` | `/skill img` або `/img` | Вибрати зображення з галереї та проаналізувати |

### Agents
| Назва | Опис |
|-------|------|
| `claude-code-docs` | Документація по Claude Code CLI |
| `termux-docs` | Документація Termux |

### Commands
| Назва | Як викликати | Опис |
|-------|-------------|------|
| `img` | `/img` | Команда для роботи із зображеннями |

---

## Підказки

- **Skills vs Agents vs Commands:**
  - `skill` — спеціалізована поведінка, тригериться явно через `/skill <name>`
  - `agent` — субагент якого Claude може запускати автоматично за контекстом
  - `command` — slash-команда `/name`, швидкий ярлик для частих дій

- Перевірити що встановлено локально:
  ```bash
  ls ~/.claude/skills/ ~/.claude/agents/ ~/.claude/commands/
  ```

- Репо: https://github.com/martfull/toolkit-alt
