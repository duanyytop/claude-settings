# Skills and Slash Commands

This document lists all custom skills and slash commands configured for Claude Code.

## Overview

Skills are custom prompts that extend Claude Code's capabilities. They can be invoked using slash commands (e.g., `/commit`, `/fix-pr-comments`) and provide specialized workflows for common development tasks.

## Global Skills

Skills installed in `~/.claude/skills/` are available across all projects.

### react-best-practices

**Slash Command:** `/react-best-practices`

**Description:** React and Next.js performance optimization guidelines from Vercel Engineering. This skill should be used when writing, reviewing, or refactoring React/Next.js code to ensure optimal performance patterns.

**When to Use:**
- Writing new React components or Next.js pages
- Implementing data fetching (client or server-side)
- Reviewing code for performance issues
- Refactoring existing React/Next.js code
- Optimizing bundle size or load times

**Key Features:**
- 40+ performance rules across 8 categories
- Priority-ordered guidelines (Critical → High → Medium → Low)
- Quick reference patterns for common scenarios
- Full documentation with code examples

**Rule Categories:**
1. **Eliminating Waterfalls** (CRITICAL)
   - Defer await, use Promise.all(), Suspense boundaries
2. **Bundle Size Optimization** (CRITICAL)
   - Avoid barrel imports, use dynamic imports
3. **Server-Side Performance** (HIGH)
   - React.cache(), LRU cache, parallel fetching
4. **Client-Side Data Fetching** (MEDIUM-HIGH)
   - SWR deduplication, defer state reads
5. **Re-render Optimization** (MEDIUM)
   - Memo, lazy state init, transitions
6. **Rendering Performance** (MEDIUM)
   - SVG animation, content-visibility
7. **JavaScript Performance** (LOW-MEDIUM)
   - Batch DOM, index maps, cache functions
8. **Advanced Patterns** (LOW)
   - Event handler refs, useLatest hook

**References:**
- Full guide: `references/react-performance-guidelines.md`
- Individual rules: `references/rules/`

---

## Project-Specific Skills

Skills installed in project `.claude/skills/` are only available within that project.

### Monday DApp Skills

Located in `~/dev/major/monday-dapp/.claude/skills/`

#### fix-pr-comments

**Slash Command:** `/fix-pr-comments [PR-number]`

**Description:** Fetch PR review comments from GitHub and generate fixes based on the feedback.

**Usage:**
```bash
# Fix comments for PR #123
/fix-pr-comments 123

# Auto-detect current branch's PR
/fix-pr-comments
```

**Workflow:**
1. Fetches PR comments using GitHub CLI
2. Analyzes comments to understand required changes
3. Creates todo list with all required fixes
4. Generates code fixes following project conventions
5. Runs type checking and linting
6. Presents changes for review before committing
7. Creates commit with reference to PR

**Features:**
- Categorizes changes by type (bug fix, refactoring, style, docs, tests)
- Prioritizes critical bugs over style changes
- Follows project patterns from CLAUDE.md
- Runs `yarn tsc && yarn lint` before committing
- References PR number in commit message

**Error Handling:**
- Checks GitHub CLI authentication
- Verifies PR exists
- Handles merge conflicts
- Informs if no comments found

---

#### generate-pr-description

**Slash Command:** `/generate-pr-description`

**Description:** Automatically generate a comprehensive pull request description based on branch changes.

**Usage:**
```bash
/generate-pr-description
```

**Generated Structure:**
```markdown
## Summary
[1-3 sentences describing purpose and impact]

## Changes
- 🎨 **Feature**: [Description]
- 🐛 **Bug Fix**: [Description]
- ♻️ **Refactor**: [Description]
- 📝 **Documentation**: [Description]
- ⚙️ **Configuration**: [Description]

## Technical Details
[Optional: architectural changes, patterns, dependencies]

## Files Changed
- `path/to/file.ts` - [Brief description]

---
🤖 Generated with Claude Code
```

**Workflow:**
1. Gathers branch information (current branch, base branch)
2. Analyzes commit history and file diffs
3. Identifies changed patterns (features, fixes, refactors)
4. Generates structured description
5. Presents to user for review or direct PR creation

**Project Context (Monday DApp):**
- Tech Stack: React 19, TypeScript 5.1.6, Redux, Zustand, Jotai, React Query
- Web3: Wagmi v2, Viem, Privy
- Styling: LESS + Ant Design 5
- Build: Vite 7 + Turborepo
- Base branch: `dev` (not `main`)

**Change Patterns:**
- State changes: Specify state layer (Redux/Zustand/Jotai/React Query)
- Web3 changes: Mention contracts, wallet, chain configs
- API changes: Endpoint and request/response structure
- Components: Location (components/ or features/)
- Theme changes: Spot or perp themes

---

## Built-in Slash Commands

These commands are provided by official Claude Code plugins.

### Commit Commands Plugin

**Available Commands:**
- `/commit` - Create a git commit
- `/commit-push-pr` - Commit, push, and open a PR
- `/clean_gone` - Clean up deleted remote branches

**Features:**
- Auto-generates commit messages following repo conventions
- Analyzes staged and unstaged changes
- Includes Co-Authored-By attribution
- Runs git hooks and pre-commit checks
- Never amends commits unless explicitly requested

---

### Code Review Plugin

**Available Commands:**
- `/code-review` - Code review a pull request

**Features:**
- Reviews PR for code quality and best practices
- Checks for security vulnerabilities
- Verifies style consistency
- Identifies potential bugs

---

### PR Review Toolkit Plugin

**Available Commands:**
- `/review-pr` - Comprehensive PR review using specialized agents

**Features:**
- Multi-agent review system
- Code quality analysis
- Test coverage validation
- Type design review
- Silent failure detection
- Comment accuracy verification

---

### Frontend Design Plugin

**Available Commands:**
- `/frontend-design` - Create distinctive, production-grade frontend interfaces

**Features:**
- High design quality components
- Avoids generic AI aesthetics
- Production-ready code
- Creative, polished implementations

---

## How to Create Custom Skills

### 1. Create Skill Directory

```bash
# Global skill (all projects)
mkdir -p ~/.claude/skills/my-skill

# Project-specific skill
mkdir -p ./.claude/skills/my-skill
```

### 2. Create skill.md File

```markdown
---
name: my-skill
description: Short description of what this skill does
---

# My Skill

## Description
Detailed description...

## Usage
How to use the skill...

---

## Instructions
Step-by-step instructions for Claude...
```

### 3. Add References (Optional)

```bash
mkdir -p ~/.claude/skills/my-skill/references
# Add documentation, examples, etc.
```

### 4. Test the Skill

```bash
claude
# Then use: /my-skill
```

---

## Best Practices

### Skill Design
- Keep skills focused on a single workflow
- Provide clear step-by-step instructions
- Include error handling guidance
- Document project-specific context

### Documentation
- Use clear, actionable language
- Include usage examples
- Document integration with other tools
- List prerequisites and dependencies

### Project Integration
- Follow project conventions (CLAUDE.md, CONVENTIONS.md)
- Use appropriate state management
- Run tests and linting before committing
- Reference related files and components

### User Experience
- Create todo lists for multi-step workflows
- Present changes for review before committing
- Provide clear commit messages
- Ask for confirmation on destructive actions

---

## Skill Management

### List Available Skills

```bash
# List all skills
ls -la ~/.claude/skills/
ls -la ./.claude/skills/

# View skill details
cat ~/.claude/skills/react-best-practices/skill.md
```

### Enable/Disable Skills

Skills are automatically enabled if present in the skills directory. To disable:
```bash
# Rename or move the skill directory
mv ~/.claude/skills/my-skill ~/.claude/skills/my-skill.disabled
```

### Update Skills

```bash
# Update skill content
vim ~/.claude/skills/my-skill/skill.md

# No restart needed - changes take effect immediately
```

---

## Integration with Plugins

Skills work seamlessly with plugins:

- **commit-commands** - Use with `/commit` after skill generates changes
- **code-review** - Use with `/review-pr` before `/fix-pr-comments`
- **typescript-lsp** - Type checking during skill execution
- **context7** - Documentation lookup for library-specific skills
- **github** - GitHub integration for PR-related skills

---

## Troubleshooting

### Skill Not Found

```bash
# Verify skill directory exists
ls -la ~/.claude/skills/my-skill/

# Verify skill.md exists
cat ~/.claude/skills/my-skill/skill.md

# Check skill name in frontmatter matches directory name
```

### Skill Not Working as Expected

1. Review skill.md instructions
2. Check for typos in slash command
3. Verify project context is correct
4. Check Claude Code version compatibility

### Debugging Skills

```bash
# View Claude Code logs
cat ~/.claude/history.jsonl | tail -n 100

# Check for errors
grep -i error ~/.claude/history.jsonl

# View task logs
cat ~/.claude/task.log
```

---

## Resources

- [Claude Code Documentation](https://docs.anthropic.com/claude/docs/claude-code)
- [Official Skills Repository](https://github.com/anthropics/claude-code-skills)
- [Plugin Documentation](./PLUGINS.md)
- [Permission Rules](./PERMISSIONS.md)
