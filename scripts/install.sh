#!/bin/bash

# Claude Code Configuration Installer
# This script installs the configuration files and scripts to ~/.claude/

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
CLAUDE_DIR="$HOME/.claude"
SCRIPTS_DIR="$CLAUDE_DIR/scripts"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}Claude Code Configuration Installer${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Create directories
echo -e "${YELLOW}Creating directories...${NC}"
mkdir -p "$CLAUDE_DIR"
mkdir -p "$SCRIPTS_DIR"

# Backup existing config if present
if [[ -f "$CLAUDE_DIR/config.json" ]]; then
    backup_file="$CLAUDE_DIR/config.json.$(date +%Y%m%d_%H%M%S).bak"
    echo -e "${YELLOW}Backing up existing config.json to $backup_file${NC}"
    cp "$CLAUDE_DIR/config.json" "$backup_file"
fi

if [[ -f "$CLAUDE_DIR/settings.json" ]]; then
    backup_file="$CLAUDE_DIR/settings.json.$(date +%Y%m%d_%H%M%S).bak"
    echo -e "${YELLOW}Backing up existing settings.json to $backup_file${NC}"
    cp "$CLAUDE_DIR/settings.json" "$backup_file"
fi

# Copy config files
echo -e "${YELLOW}Installing configuration files...${NC}"
cp "$REPO_DIR/config/config.json" "$CLAUDE_DIR/config.json"
cp "$REPO_DIR/config/settings.json" "$CLAUDE_DIR/settings.json"

# Copy scripts
echo -e "${YELLOW}Installing scripts...${NC}"
cp "$REPO_DIR/scripts/notify.sh" "$SCRIPTS_DIR/"
cp "$REPO_DIR/scripts/task-summary.sh" "$SCRIPTS_DIR/"
cp "$REPO_DIR/scripts/view-logs.sh" "$SCRIPTS_DIR/"
cp "$REPO_DIR/scripts/clear-logs.sh" "$SCRIPTS_DIR/"
cp "$REPO_DIR/scripts/setup-aliases.sh" "$SCRIPTS_DIR/"

# Make scripts executable
chmod +x "$SCRIPTS_DIR"/*.sh

# Copy README
cp "$REPO_DIR/docs/NOTIFICATION.md" "$CLAUDE_DIR/README.md"

echo ""
echo -e "${GREEN}Installation complete!${NC}"
echo ""
echo -e "${BLUE}Installed files:${NC}"
echo -e "  ${GREEN}$CLAUDE_DIR/config.json${NC}"
echo -e "  ${GREEN}$CLAUDE_DIR/settings.json${NC}"
echo -e "  ${GREEN}$SCRIPTS_DIR/notify.sh${NC}"
echo -e "  ${GREEN}$SCRIPTS_DIR/task-summary.sh${NC}"
echo -e "  ${GREEN}$SCRIPTS_DIR/view-logs.sh${NC}"
echo -e "  ${GREEN}$SCRIPTS_DIR/clear-logs.sh${NC}"
echo -e "  ${GREEN}$SCRIPTS_DIR/setup-aliases.sh${NC}"
echo ""
echo -e "${YELLOW}To set up shell aliases, run:${NC}"
echo -e "${GREEN}~/.claude/scripts/setup-aliases.sh${NC}"
echo ""
