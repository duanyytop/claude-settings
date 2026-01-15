# Custom Skills

This directory contains custom skills for Claude Code. Skills are specialized prompts that can be invoked using slash commands.

## Available Skills

### react-best-practices
- **Command:** `/react-best-practices`
- **Location:** Global (`~/.claude/skills/`)
- **Purpose:** React and Next.js performance optimization guidelines
- **Documentation:** [SKILLS.md](../docs/SKILLS.md#react-best-practices)

### fix-pr-comments
- **Command:** `/fix-pr-comments [PR-number]`
- **Location:** Project-specific (Monday DApp)
- **Purpose:** Fetch and fix GitHub PR review comments
- **Documentation:** [SKILLS.md](../docs/SKILLS.md#fix-pr-comments)

### generate-pr-description
- **Command:** `/generate-pr-description`
- **Location:** Project-specific (Monday DApp)
- **Purpose:** Auto-generate PR descriptions based on branch changes
- **Documentation:** [SKILLS.md](../docs/SKILLS.md#generate-pr-description)

## Installation

### Global Skills (All Projects)

Copy to `~/.claude/skills/`:

```bash
# Install react-best-practices
cp -r skills/react-best-practices ~/.claude/skills/
```

### Project-Specific Skills

Copy to `./.claude/skills/` in your project:

```bash
# Install fix-pr-comments
mkdir -p ./.claude/skills
cp -r skills/fix-pr-comments ./.claude/skills/

# Install generate-pr-description
cp -r skills/generate-pr-description ./.claude/skills/
```

## Creating Your Own Skills

1. Create a directory with your skill name:
```bash
mkdir -p ~/.claude/skills/my-skill
```

2. Create `skill.md` with frontmatter:
```markdown
---
name: my-skill
description: What this skill does
---

# My Skill

## Description
Detailed description...

---

## Instructions
Step-by-step instructions for Claude...
```

3. Add references (optional):
```bash
mkdir -p ~/.claude/skills/my-skill/references
# Add documentation, examples, etc.
```

4. Use the skill:
```bash
claude
# Then: /my-skill
```

## Skill Structure

```
skill-name/
├── skill.md              # Main skill definition (required)
└── references/           # Optional documentation
    ├── guide.md
    └── examples/
```

### skill.md Format

```markdown
---
name: skill-name         # Must match directory name
description: Brief description shown in skill list
---

# Skill Title

## Description
What this skill does and when to use it

## Usage
How to invoke the skill

## Examples
Usage examples

---

## Instructions
Detailed step-by-step instructions for Claude Code
```

## Best Practices

1. **Focus on Workflows** - Each skill should handle a specific workflow
2. **Clear Instructions** - Provide step-by-step guidance
3. **Include Context** - Document project-specific conventions
4. **Error Handling** - Explain how to handle common errors
5. **Integration** - Document how to use with other tools/plugins

## Documentation

For detailed documentation on all skills and how to use them, see:
- [SKILLS.md](../docs/SKILLS.md) - Complete skills reference
- [PLUGINS.md](../docs/PLUGINS.md) - Plugin integration
- [README.md](../README.md) - General setup

## Troubleshooting

### Skill Not Found
```bash
# Verify skill exists
ls -la ~/.claude/skills/my-skill/

# Check skill.md frontmatter
cat ~/.claude/skills/my-skill/skill.md
```

### Skill Not Working
1. Verify directory name matches skill name in frontmatter
2. Check for syntax errors in skill.md
3. Review Claude Code logs: `~/.claude/history.jsonl`

## Examples

### Minimal Skill

```markdown
---
name: hello
description: Say hello
---

# Hello Skill

## Instructions
When invoked, greet the user with "Hello from Claude Code!"
```

### Advanced Skill with References

```
my-advanced-skill/
├── skill.md
└── references/
    ├── overview.md
    ├── api-reference.md
    └── examples/
        ├── basic.md
        └── advanced.md
```

## Contributing

To add your skill to this repository:
1. Create the skill following the structure above
2. Test it thoroughly
3. Document it in [SKILLS.md](../docs/SKILLS.md)
4. Submit a pull request

## Resources

- [Claude Code Documentation](https://docs.anthropic.com/claude/docs/claude-code)
- [Official Skills Repository](https://github.com/anthropics/claude-code-skills)
- [Skill Development Guide](../docs/SKILLS.md#how-to-create-custom-skills)
