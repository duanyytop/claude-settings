#!/bin/bash

# Clear Claude Code logs
# Usage: clear-logs.sh [--force]

LOG_FILE="$HOME/.claude/task.log"
FORCE="${1:-}"

# Colors
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

if [[ ! -f "$LOG_FILE" ]]; then
    echo -e "${YELLOW}No log file to clear.${NC}"
    exit 0
fi

log_size=$(wc -l < "$LOG_FILE")

if [[ "$FORCE" != "--force" ]]; then
    echo -e "${YELLOW}This will delete $log_size log entries.${NC}"
    echo -e "${YELLOW}Run with --force to confirm: clear-logs.sh --force${NC}"
    exit 0
fi

# Backup old log
backup_file="$HOME/.claude/task.log.$(date +%Y%m%d_%H%M%S).bak"
cp "$LOG_FILE" "$backup_file"

# Clear log
> "$LOG_FILE"

echo -e "${GREEN}Log file cleared!${NC}"
echo -e "${GREEN}Backup saved to: $backup_file${NC}"
echo -e "${GREEN}Removed $log_size entries.${NC}"
