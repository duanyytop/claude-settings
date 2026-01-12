# Claude Code Notification and Logging System

## Directory Structure

```
~/.claude/
├── config.json              # Claude Code configuration file (hooks definition)
├── task.log                 # Task log file (auto-generated)
├── scripts/
│   ├── notify.sh           # Main notification script
│   ├── task-summary.sh     # Task statistics summary
│   ├── view-logs.sh        # Log viewer
│   └── clear-logs.sh       # Log cleanup
└── README.md               # This document
```

## Notification Features

### Configured Hooks

1. **task-complete** - Notification when task completes
   - Sound: Glass (crisp)
   - Message: Task completed successfully

2. **task-error** - Notification when task errors
   - Sound: Basso (warning tone)
   - Message: Task failed with error

3. **task-start** - Notification when task starts
   - Sound: Ping (brief)
   - Message: Task started

### Features

- macOS native notifications
- Auto-logging to `~/.claude/task.log`
- Colored terminal output
- Different sounds for different task types

## Utility Scripts

### 1. View Task Summary

```bash
~/.claude/scripts/task-summary.sh
```

Shows:
- Successful task count
- Failed task count
- Total task count
- Success rate
- Last 5 task records

### 2. View Logs

```bash
# View last 20 logs (default)
~/.claude/scripts/view-logs.sh

# View last 50 logs
~/.claude/scripts/view-logs.sh 50

# View logs containing "error"
~/.claude/scripts/view-logs.sh 20 error
```

### 3. Clear Logs

```bash
# Show confirmation prompt
~/.claude/scripts/clear-logs.sh

# Force clear (auto-backup)
~/.claude/scripts/clear-logs.sh --force
```

## Shell Alias Configuration

Add the following to your `~/.zshrc` or `~/.bashrc`:

```bash
# Claude Code shortcuts
alias claude-summary='~/.claude/scripts/task-summary.sh'
alias claude-logs='~/.claude/scripts/view-logs.sh'
alias claude-clear='~/.claude/scripts/clear-logs.sh'
alias claude-test='~/.claude/scripts/notify.sh "Test notification" "Glass" "Testing..."'
```

Apply configuration:
```bash
source ~/.zshrc  # or source ~/.bashrc
```

## Custom Configuration

### Change Notification Sound

Edit `~/.claude/config.json`, available macOS sounds include:
- Glass (crisp)
- Ping (brief)
- Pop (light)
- Basso (deep)
- Hero (heroic)
- Submarine (submarine)
- Tink (ding)

### Modify Notification Message

In `~/.claude/config.json`, modify the `command` field:

```json
{
  "hooks": {
    "task-complete": {
      "command": "~/.claude/scripts/notify.sh 'Your custom message' 'SoundName' 'Subtitle'",
      "description": "Your description"
    }
  }
}
```

### Add New Hook

Available hook types:
- `task-start` - Task start
- `task-complete` - Task complete
- `task-error` - Task error
- `tool-use` - Tool usage
- `user-prompt-submit` - User prompt submit

Example:
```json
{
  "hooks": {
    "tool-use": {
      "command": "~/.claude/scripts/notify.sh 'Tool used: $TOOL_NAME' 'Pop'",
      "description": "Notify on tool usage"
    }
  }
}
```

## Test Notifications

Run these commands to test if notifications work:

```bash
# Success notification
~/.claude/scripts/notify.sh "Task completed successfully" "Glass"

# Error notification
~/.claude/scripts/notify.sh "Task failed with error" "Basso"

# Start notification
~/.claude/scripts/notify.sh "Task started" "Ping"
```

## Log Format

Log file (`~/.claude/task.log`) format:

```
[2026-01-12 15:30:45] [SUCCESS] Task completed successfully
[2026-01-12 15:31:02] [ERROR] Task failed with error
[2026-01-12 15:31:20] [INFO] Task started
```

## Troubleshooting

### Notifications Not Showing

1. Check script permissions:
   ```bash
   ls -l ~/.claude/scripts/*.sh
   # Should show -rwxr-xr-x
   ```

2. Test notification manually:
   ```bash
   osascript -e 'display notification "Test" with title "Test" sound name "Glass"'
   ```

3. Check system notification settings:
   System Settings > Notifications > Script Editor (allow notifications)

### Hooks Not Executing

1. Check config file format:
   ```bash
   cat ~/.claude/config.json | python3 -m json.tool
   ```

2. Check Claude Code logs for errors

3. Test if script is executable:
   ```bash
   ~/.claude/scripts/notify.sh "Test message"
   ```
