# Claude Code Settings

Personal configuration repository for [Claude Code](https://claude.ai/code) - Anthropic's CLI tool for Claude.

## Directory Structure

```
claude-settings/
├── config/
│   ├── config.json              # Hooks configuration
│   ├── settings.json            # Permissions & plugin settings
│   └── settings.local.example.json  # Local settings template
├── scripts/
│   ├── notify.sh                # macOS notification script
│   ├── task-summary.sh          # Task statistics viewer
│   ├── view-logs.sh             # Log viewer
│   ├── clear-logs.sh            # Log cleanup utility
│   ├── setup-aliases.sh         # Shell aliases setup
│   └── install.sh               # Configuration installer
├── docs/
│   ├── NOTIFICATION.md          # Notification system docs
│   ├── PERMISSIONS.md           # Permission rules reference
│   └── PLUGINS.md               # Plugin configuration guide
└── README.md
```

## Quick Start

### Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/claude-settings.git
cd claude-settings

# Run the installer
./scripts/install.sh

# Set up shell aliases (optional)
~/.claude/scripts/setup-aliases.sh
source ~/.zshrc  # or source ~/.bashrc
```

### Manual Installation

Copy files to `~/.claude/`:

```bash
cp config/config.json ~/.claude/
cp config/settings.json ~/.claude/
cp scripts/*.sh ~/.claude/scripts/
chmod +x ~/.claude/scripts/*.sh
```

## Features

### Notification System

macOS native notifications for task events:

- **Task Complete** - Glass sound with success notification
- **Task Error** - Basso sound with error notification
- **Task Start** - Ping sound with start notification

All events are logged to `~/.claude/task.log`.

### Permission Rules

Pre-configured safe permissions:

**Allowed:**
- Read all files
- Write common code files (*.ts, *.js, *.py, *.go, etc.)
- Common dev commands (git, npm, yarn, docker, etc.)

**Denied:**
- Sensitive files (.env.local, credentials, SSH keys)
- Dangerous commands (rm -rf, sudo, force push)
- Publishing commands (npm publish, docker push)

### Enabled Plugins

- `typescript-lsp` - TypeScript language server
- `pyright-lsp` - Python type checker
- `gopls-lsp` - Go language server
- `context7` - Documentation lookup
- `github` - GitHub integration
- `frontend-design` - UI/UX design tools
- `commit-commands` - Git commit helpers

## Shell Aliases

After running `setup-aliases.sh`:

| Command | Description |
|---------|-------------|
| `claude-summary` | View task statistics |
| `claude-logs` | View recent logs |
| `claude-logs 50` | View last 50 entries |
| `claude-logs 20 error` | View error logs |
| `claude-clear --force` | Clear logs (with backup) |
| `claude-test` | Test notification |
| `claude-help` | Show documentation |

## Configuration Reference

### config.json (Hooks)

```json
{
  "hooks": {
    "task-complete": {
      "command": "~/.claude/scripts/notify.sh 'Message' 'Sound' 'Subtitle'",
      "description": "Description"
    }
  }
}
```

### settings.json (Permissions)

```json
{
  "permissions": {
    "allow": ["Read:**/*", "Bash(git:*)"],
    "deny": ["Write(.env.local)", "Bash(sudo:*)"],
    "defaultMode": "default"
  },
  "enabledPlugins": {
    "typescript-lsp@claude-plugins-official": true
  }
}
```

## Customization

### Add Custom Hooks

Available hook types:
- `task-start` - Task begins
- `task-complete` - Task succeeds
- `task-error` - Task fails
- `tool-use` - Tool invoked
- `user-prompt-submit` - User sends prompt

### Modify Notification Sounds

Available macOS sounds:
- Glass, Ping, Pop, Basso, Hero, Submarine, Tink

### Add Project-Specific Settings

Create `.claude/settings.json` in your project directory for project-specific overrides.

## Contributing

Feel free to submit issues and pull requests for improvements.

## License

MIT License
