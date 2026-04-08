# toolkit-alt

Claude Code agents, skills & commands — синхронізація між пристроями.

## Структура

```
.claude/skills/   — скіли (підключаються через /skill)
agents/           — агенти (~/.claude/agents/)
commands/         — slash-команди (~/.claude/commands/)
scripts/          — утиліти синхронізації
```

## Встановлення на новому пристрої

```bash
git clone https://github.com/martfull/toolkit-alt.git
cd toolkit-alt
chmod +x scripts/sync-pull.sh
./scripts/sync-pull.sh
```

## Синхронізація

```bash
# Завантажити зміни з GitHub → ~/.claude/
./scripts/sync-pull.sh

# Вивантажити зміни з ~/.claude/ → GitHub
./scripts/sync-push.sh
```

## Вміст

### Skills
| Назва | Опис |
|-------|------|
| `img` | Вибрати зображення з галереї та проаналізувати |

### Agents
| Назва | Опис |
|-------|------|
| `claude-code-docs` | Документація Claude Code |
| `termux-docs` | Документація Termux |
| `git-agent` | Git операції: commits, branches, push/pull, PR |

### Commands
| Назва | Опис |
|-------|------|
| `img` | Команда для роботи із зображеннями |
