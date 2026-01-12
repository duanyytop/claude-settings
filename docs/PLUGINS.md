# Claude Code Plugin Configuration

This document explains the plugin configuration in `settings.json`.

## Enabled Plugins

### Language Servers

#### TypeScript LSP
```json
"typescript-lsp@claude-plugins-official": true
```
Provides:
- Type checking
- Auto-completion
- Hover information
- Go to definition
- Find references

#### Pyright LSP
```json
"pyright-lsp@claude-plugins-official": true
```
Provides:
- Python type checking
- Static analysis
- Auto-imports
- Symbol search

#### Go LSP (gopls)
```json
"gopls-lsp@claude-plugins-official": true
```
Provides:
- Go language features
- Formatting
- Diagnostics
- Code navigation

### Development Tools

#### Context7
```json
"context7@claude-plugins-official": true
```
Provides:
- Documentation lookup
- API reference search
- Code examples from official docs

#### GitHub Integration
```json
"github@claude-plugins-official": true
```
Provides:
- PR creation and management
- Issue tracking
- Repository operations
- Code review features

#### Frontend Design
```json
"frontend-design@claude-plugins-official": true
```
Provides:
- UI component generation
- Design system integration
- Responsive layout helpers

#### Commit Commands
```json
"commit-commands@claude-plugins-official": true
```
Provides:
- `/commit` - Create git commit
- `/commit-push-pr` - Commit, push, and create PR
- `/clean_gone` - Clean up deleted branches

## MCP Servers

### Enable All Project MCP Servers

```json
"enableAllProjectMcpServers": true
```

Automatically enables MCP servers defined in project `.mcp.json` files.

### Enable Specific MCP Servers

```json
"enabledMcpjsonServers": ["*"]
```

Use `["*"]` to enable all, or specify server names.

## Adding Custom Plugins

### From Official Marketplace

```json
{
  "enabledPlugins": {
    "plugin-name@claude-plugins-official": true
  }
}
```

### Project-Specific MCP Server

Create `.mcp.json` in project root:

```json
{
  "servers": {
    "my-server": {
      "command": "node",
      "args": ["./my-mcp-server.js"]
    }
  }
}
```

## Session Hooks

### Language Rule Hook

```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "*",
        "hooks": [
          {
            "type": "prompt",
            "prompt": "Always respond in English regardless of input language."
          }
        ]
      }
    ]
  }
}
```

Hook types:
- `prompt` - Inject system prompt
- `command` - Execute shell command

## Plugin Discovery

View available plugins:
```bash
claude plugins list
```

Install plugin:
```bash
claude plugins install plugin-name@marketplace
```

## Best Practices

1. **Enable Only Needed Plugins** - Each plugin adds overhead
2. **Use LSPs for Your Stack** - Enable language servers for languages you use
3. **Review Plugin Permissions** - Understand what each plugin can access
4. **Keep Updated** - Regularly update plugins for bug fixes and features
