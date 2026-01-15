# Generate PR Description

Automatically generate a comprehensive pull request description based on your changes.

## Description

This skill analyzes your branch changes and generates a well-structured PR description including:
1. Summary of changes
2. Detailed change list
3. Technical details (if significant architectural changes)
4. Test plan suggestions
5. Related files and components

## Usage

```
/generate-pr-description
```

Analyzes the current branch and generates a PR description ready to use with `gh pr create`.

## Examples

```
/generate-pr-description
```

Generates a PR description for the current branch comparing it to the main branch.

---

## Instructions

You are helping the user create a comprehensive PR description. Follow these steps:

### Step 1: Gather Branch Information

1. Get current branch name:
   ```bash
   git branch --show-current
   ```

2. Identify the base branch (usually `dev` or `main`):
   ```bash
   git remote show origin | grep 'HEAD branch' | cut -d' ' -f5
   ```

   Note: For this project, the main branch is `dev` (not `main`).

3. Get commit history:
   ```bash
   git log dev..HEAD --oneline
   ```

### Step 2: Analyze Changes

1. Get file changes summary:
   ```bash
   git diff dev..HEAD --stat
   ```

2. Get detailed diff (limit to reasonable size):
   ```bash
   git diff dev..HEAD --unified=3
   ```

3. Identify changed file types and patterns:
   - New features (new files, new directories)
   - Bug fixes (fixes in existing files)
   - Refactoring (file moves, renames)
   - Configuration changes
   - Documentation updates

### Step 3: Generate PR Description

Create a structured PR description with the following format:

```markdown
## Summary

[1-3 sentences describing the main purpose and impact of this PR]

## Changes

- 🎨 **Feature**: [Description of new features]
- 🐛 **Bug Fix**: [Description of bug fixes]
- ♻️ **Refactor**: [Description of refactoring]
- 📝 **Documentation**: [Description of doc updates]
- ⚙️ **Configuration**: [Description of config changes]

## Technical Details

[Optional: Include this section only if there are significant architectural changes, new patterns, or complex implementations]

- Technical decision or pattern used
- New dependencies added
- Breaking changes (if any)

## Files Changed

- `path/to/file.ts` - [Brief description]
- `path/to/component/` - [Brief description]

---

🤖 Generated with [Claude Code](https://claude.com/claude-code)
```

### Step 4: Guidelines for Content

**Summary Guidelines:**
- Be concise but informative (1-3 sentences)
- Focus on the "why" and "what" (not the "how")
- Mention user impact if applicable
- Examples:
  - ✅ "Implement one-click trading feature to enable gas-free perpetual trades through account delegation"
  - ❌ "Added some files and changed code"

**Changes Guidelines:**
- Use emoji prefixes for visual clarity:
  - 🎨 Feature - New functionality
  - 🐛 Bug Fix - Fixes issues
  - ♻️ Refactor - Code improvements without behavior change
  - 📝 Documentation - Docs, comments, README
  - ⚙️ Configuration - Config files, build setup
  - 🎨 UI/UX - Visual or interaction improvements
  - 🔧 Tooling - Development tools, scripts
  - 🧪 Tests - Test additions or updates
- Group related changes together
- Be specific but concise

**Technical Details Guidelines:**
- Only include if there are:
  - New architectural patterns
  - Significant technical decisions
  - New dependencies or libraries
  - Breaking changes
  - Performance considerations
- Skip this section for simple changes

**Test Plan Guidelines:**
- Provide actionable test steps
- Include both automated and manual testing
- Mention regression test areas
- Be specific about what to verify

### Step 5: Project-Specific Context

For Monday DApp specifically:

**Tech Stack Context:**
- React 19 + TypeScript 5.1.6
- State: Redux Toolkit + Zustand + Jotai + React Query
- Web3: Wagmi v2, Viem, Privy
- Styling: LESS + Ant Design 5
- Build: Vite 7 + Turborepo

**Common Change Patterns:**
- **State changes**: Mention which state management layer (Redux/Zustand/Jotai/React Query)
- **Web3 changes**: Mention contract interactions, wallet connections, chain configs
- **API changes**: Mention endpoint, request/response structure
- **Component changes**: Mention location (components/ or features/)
- **Theme changes**: Mention if it affects spot or perp themes

**Branch Naming Context:**
- `feat/*` - New features
- `fix/*` - Bug fixes
- `refactor/*` - Refactoring
- `docs/*` - Documentation
- `chore/*` - Maintenance

### Step 6: Present to User

After generating the description:

1. Show the complete PR description
2. Ask if they want to:
   - Copy it to clipboard (provide the text in a code block)
   - Create PR directly using `gh pr create`
   - Make modifications first

### Step 7: Create PR (if requested)

If user wants to create PR:

```bash
gh pr create --title "[Title]" --body "$(cat <<'EOF'
[Generated PR description]
EOF
)"
```

## Important Notes

- **Always analyze actual changes** - Don't make assumptions about what changed
- **Be accurate** - Verify commit messages and file diffs
- **Keep it concise** - Focus on important changes, not every line
- **Use project conventions** - Follow the patterns in CLAUDE.md
- **Check base branch** - This project uses `dev` as the main branch, not `main`
- **Skip noise** - Don't mention trivial changes like formatting or whitespace unless they're significant

## Error Handling

If git commands fail:
- Verify you're in a git repository
- Check if current branch is ahead of base branch
- Ensure base branch exists

If no meaningful changes found:
- Inform the user there are no changes to describe
- Suggest they make commits first

## Integration with Other Tools

This skill works well with:
- `/commit` - For creating commits before generating PR description
- `/fix-pr-comments` - For addressing review feedback after PR creation
- `yarn test` - For verifying test coverage before creating PR
