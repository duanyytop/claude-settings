# Claude Code Permission Rules

This document explains the permission configuration in `settings.json`.

## Permission Format

Permissions use a pattern-based syntax:

```
Tool(pattern)
Tool:**/pattern
```

## File Permissions

### Read Permissions

```json
"Read:**/*"  // Read all files
```

### Write Permissions

Allow writing to common code file types:

```json
"Write:**/*.ts",     // TypeScript
"Write:**/*.tsx",    // TypeScript React
"Write:**/*.js",     // JavaScript
"Write:**/*.jsx",    // JavaScript React
"Write:**/*.py",     // Python
"Write:**/*.go",     // Go
"Write:**/*.rs",     // Rust
"Write:**/*.json",   // JSON
"Write:**/*.md",     // Markdown
"Write:**/*.yml",    // YAML
"Write:**/*.yaml",   // YAML
"Write:**/*.sql",    // SQL
"Write:**/*.sh",     // Shell scripts
```

### Edit Permissions

Same patterns as Write, but for the Edit tool.

## Bash Command Permissions

### Development Tools

```json
"Bash(git:*)",         // Git commands
"Bash(npm:*)",         // npm commands
"Bash(yarn:*)",        // Yarn commands
"Bash(pnpm:*)",        // pnpm commands
"Bash(node:*)",        // Node.js
"Bash(python:*)",      // Python
"Bash(go:*)",          // Go
"Bash(cargo:*)",       // Rust Cargo
"Bash(docker:*)",      // Docker
"Bash(kubectl:*)",     // Kubernetes
```

### Build & Test Tools

```json
"Bash(tsc:*)",         // TypeScript compiler
"Bash(eslint:*)",      // ESLint
"Bash(prettier:*)",    // Prettier
"Bash(jest:*)",        // Jest testing
"Bash(vitest:*)",      // Vitest testing
"Bash(pytest:*)",      // Python testing
"Bash(make:*)",        // Make
```

### System Commands

```json
"Bash(ls:*)",          // List files
"Bash(mkdir:*)",       // Create directories
"Bash(cp:*)",          // Copy files
"Bash(mv:*)",          // Move files
"Bash(chmod:*)",       // Change permissions
"Bash(curl:*)",        // HTTP requests
"Bash(wget:*)",        // Download files
```

## Denied Permissions

### Sensitive Files

```json
"Write(.env.local)",           // Local env files
"Write(.env.production)",      // Production env
"Write(secrets/**)",           // Secrets directory
"Write(credentials.json)",     // Credentials
"Write(.ssh/**)",              // SSH keys
"Write(**/*.pem)",             // Certificates
"Write(**/*.key)",             // Private keys
```

### Dangerous Commands

```json
"Bash(rm -rf:*)",              // Recursive delete
"Bash(sudo:*)",                // Superuser
"Bash(chmod 777:*)",           // Unsafe permissions
```

### Publishing Commands

```json
"Bash(npm publish:*)",         // npm publish
"Bash(yarn publish:*)",        // yarn publish
"Bash(docker push:*)",         // Docker push
"Bash(cargo publish:*)",       // Cargo publish
```

### Git Safety

```json
"Bash(git push --force:*)",    // Force push
"Bash(git push -f:*)",         // Force push short
"Bash(git push --force origin master)",
"Bash(git push --force origin main)",
```

## Project-Specific Permissions

Create `.claude/settings.json` in your project root:

```json
{
  "permissions": {
    "allow": [
      "Bash(my-custom-command:*)"
    ],
    "deny": []
  }
}
```

## Permission Modes

- `default` - Standard permission checking
- `ask` - Prompt for each action
- `trust` - Allow all (use with caution)

Set in settings.json:

```json
{
  "permissions": {
    "defaultMode": "default"
  }
}
```

## Best Practices

1. **Principle of Least Privilege** - Only allow what's needed
2. **Deny Sensitive Operations** - Protect secrets and credentials
3. **Review Regularly** - Update permissions as needs change
4. **Use Project Settings** - Override globally for specific projects
5. **Test Before Trusting** - Verify behavior before enabling trust mode
