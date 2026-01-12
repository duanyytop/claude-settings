#!/bin/bash

# Setup shell aliases for Claude Code scripts

YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}Claude Code - Shell Aliases Setup${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Detect shell
if [[ -n "$ZSH_VERSION" ]]; then
    SHELL_RC="$HOME/.zshrc"
    SHELL_NAME="zsh"
elif [[ -n "$BASH_VERSION" ]]; then
    SHELL_RC="$HOME/.bashrc"
    SHELL_NAME="bash"
else
    echo -e "${YELLOW}Unknown shell. Please manually add aliases.${NC}"
    exit 1
fi

echo -e "${YELLOW}Detected shell: $SHELL_NAME${NC}"
echo -e "${YELLOW}Config file: $SHELL_RC${NC}"
echo ""

# Aliases to add
ALIASES="
# Claude Code aliases (added by setup script)
alias claude-summary='~/.claude/scripts/task-summary.sh'
alias claude-logs='~/.claude/scripts/view-logs.sh'
alias claude-clear='~/.claude/scripts/clear-logs.sh'
alias claude-test='~/.claude/scripts/notify.sh \"Test notification\" \"Glass\" \"Testing...\"'
alias claude-help='cat ~/.claude/README.md'
"

# Check if aliases already exist
if grep -q "Claude Code aliases" "$SHELL_RC" 2>/dev/null; then
    echo -e "${YELLOW}Aliases already exist in $SHELL_RC${NC}"
    echo -e "${YELLOW}Skipping to avoid duplicates.${NC}"
else
    # Add aliases
    echo "$ALIASES" >> "$SHELL_RC"
    echo -e "${GREEN}Aliases added to $SHELL_RC${NC}"
fi

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}Setup complete!${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${YELLOW}To use the aliases, run:${NC}"
echo -e "${GREEN}source $SHELL_RC${NC}"
echo ""
echo -e "${YELLOW}Available commands:${NC}"
echo -e "  ${GREEN}claude-summary${NC}  - View task statistics"
echo -e "  ${GREEN}claude-logs${NC}     - View recent logs"
echo -e "  ${GREEN}claude-clear${NC}    - Clear log file"
echo -e "  ${GREEN}claude-test${NC}     - Test notification"
echo -e "  ${GREEN}claude-help${NC}     - Show documentation"
echo ""
