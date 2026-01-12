#!/bin/bash

# Claude Code Task Summary Script
# Shows statistics from task log

LOG_FILE="$HOME/.claude/task.log"

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}Claude Code Task Summary${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

if [[ ! -f "$LOG_FILE" ]]; then
    echo -e "${YELLOW}No task log found yet.${NC}"
    exit 0
fi

# Count tasks by type
total_tasks=$(wc -l < "$LOG_FILE" | tr -d ' ')
success_tasks=$(grep -c "SUCCESS" "$LOG_FILE" 2>/dev/null)
error_tasks=$(grep -c "ERROR" "$LOG_FILE" 2>/dev/null)
info_tasks=$(grep -c "INFO" "$LOG_FILE" 2>/dev/null)

# Calculate success rate
if [[ $total_tasks -gt 0 && $success_tasks -gt 0 ]]; then
    success_rate=$(echo "scale=1; ($success_tasks / $total_tasks) * 100" | bc)
else
    success_rate="0.0"
fi

echo ""
echo -e "${GREEN}Successful tasks: $success_tasks${NC}"
echo -e "${RED}Failed tasks:     $error_tasks${NC}"
echo -e "${YELLOW}Info tasks:       $info_tasks${NC}"
echo -e "${BLUE}Total tasks:      $total_tasks${NC}"
echo ""
echo -e "${GREEN}Success rate:     $success_rate%${NC}"
echo ""

# Show last 5 tasks
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}Last 5 Tasks:${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
tail -5 "$LOG_FILE" | while IFS= read -r line; do
    if [[ $line == *"SUCCESS"* ]]; then
        echo -e "${GREEN}$line${NC}"
    elif [[ $line == *"ERROR"* ]]; then
        echo -e "${RED}$line${NC}"
    else
        echo -e "${YELLOW}$line${NC}"
    fi
done
echo ""
