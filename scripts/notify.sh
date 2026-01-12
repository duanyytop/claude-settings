#!/bin/bash

# Claude Code Notification Script
# Usage: notify.sh <message> [sound] [subtitle]

TITLE="Claude Code"
MESSAGE="${1:-Task completed}"
SOUND="${2:-Glass}"
SUBTITLE="${3:-}"

# Colors for terminal output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Log file location
LOG_FILE="$HOME/.claude/task.log"

# Create log file if it doesn't exist
touch "$LOG_FILE"

# Log to file with timestamp
log_message() {
    local level="$1"
    local msg="$2"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$level] $msg" >> "$LOG_FILE"
}

# Send macOS notification
send_notification() {
    local msg="$1"
    local sound="$2"
    local subtitle_part=""

    if [[ -n "$SUBTITLE" ]]; then
        subtitle_part="subtitle \"$SUBTITLE\""
    fi

    osascript -e "display notification \"$msg\" with title \"$TITLE\" $subtitle_part sound name \"$sound\""
}

# Terminal output with color
terminal_output() {
    local color="$1"
    local msg="$2"
    echo -e "${color}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${color}Claude Code: $msg${NC}"
    echo -e "${color}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

# Main notification logic
case "$MESSAGE" in
    *"completed"*|*"success"*)
        log_message "SUCCESS" "$MESSAGE"
        terminal_output "$GREEN" "$MESSAGE"
        send_notification "$MESSAGE" "$SOUND"
        ;;
    *"error"*|*"failed"*|*"fail"*)
        log_message "ERROR" "$MESSAGE"
        terminal_output "$RED" "$MESSAGE"
        send_notification "$MESSAGE" "Basso"
        ;;
    *"started"*|*"begin"*)
        log_message "INFO" "$MESSAGE"
        terminal_output "$YELLOW" "$MESSAGE"
        send_notification "$MESSAGE" "Ping"
        ;;
    *)
        log_message "INFO" "$MESSAGE"
        terminal_output "$YELLOW" "$MESSAGE"
        send_notification "$MESSAGE" "$SOUND"
        ;;
esac
