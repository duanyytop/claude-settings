#!/bin/bash

# Claude Code Log Viewer
# Usage: view-logs.sh [lines] [filter]

LOG_FILE="$HOME/.claude/task.log"
LINES="${1:-20}"
FILTER="${2:-}"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

if [[ ! -f "$LOG_FILE" ]]; then
    echo -e "${YELLOW}No task log found yet.${NC}"
    exit 0
fi

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}Claude Code Task Logs (Last $LINES entries)${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Apply filter if provided
if [[ -n "$FILTER" ]]; then
    echo -e "${YELLOW}Filter: $FILTER${NC}"
    echo ""
    logs=$(grep -i "$FILTER" "$LOG_FILE" | tail -"$LINES")
else
    logs=$(tail -"$LINES" "$LOG_FILE")
fi

# Color code the output
echo "$logs" | while IFS= read -r line; do
    if [[ $line == *"SUCCESS"* ]]; then
        echo -e "${GREEN}$line${NC}"
    elif [[ $line == *"ERROR"* ]]; then
        echo -e "${RED}$line${NC}"
    elif [[ $line == *"INFO"* ]]; then
        echo -e "${YELLOW}$line${NC}"
    else
        echo "$line"
    fi
done

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}Usage: view-logs.sh [lines] [filter]${NC}"
echo -e "${BLUE}Example: view-logs.sh 50 error${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
