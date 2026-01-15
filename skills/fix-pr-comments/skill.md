# Fix PR Comments

Fetch PR comments from GitHub and generate fixes based on the feedback.

## Description

This skill helps you address PR review comments by:
1. Fetching all comments from a specified PR using GitHub CLI
2. Analyzing the comments to understand required changes
3. Generating code fixes based on the feedback
4. Presenting the changes for your review before committing

## Usage

```
/fix-pr-comments [PR-number]
```

If no PR number is provided, it will attempt to detect the current branch's PR.

## Examples

```
/fix-pr-comments 123
```

Fetches comments from PR #123 and generates fixes.

```
/fix-pr-comments
```

Detects the current branch's PR and generates fixes.

---

## Instructions

You are helping the user address PR review comments. Follow these steps:

### Step 1: Fetch PR Information

1. If the user provided a PR number, use it directly
2. If not, detect the current branch's PR:
   ```bash
   gh pr status --json number,headRefName | jq -r '.currentBranch.number'
   ```

### Step 2: Fetch PR Comments

Use GitHub CLI to fetch all comments:
```bash
gh pr view [PR-number] --json comments,reviews,reviewThreads
```

Parse the output to extract:
- Review comments with file paths and line numbers
- General PR comments
- Review thread discussions
- Suggested changes

### Step 3: Analyze Comments

For each comment:
1. Identify the file and line number (if applicable)
2. Extract the reviewer's concern or suggestion
3. Categorize the type of change needed:
   - Code fix (bug, logic error)
   - Code improvement (refactoring, optimization)
   - Style/convention change
   - Documentation update
   - Test addition/modification

### Step 4: Create Todo List

Use the TodoWrite tool to create a comprehensive todo list with:
- Each comment as a separate task
- File path and line number reference
- Brief description of the required change
- Priority based on severity (critical bugs first, style changes last)

Example todo format:
```
- Fix type error in src/components/Balance/index.tsx:45 (in_progress)
- Refactor useTokenBalance hook to use React Query (pending)
- Add error handling to handleSwap function (pending)
- Update JSDoc comments in api.ts (pending)
```

### Step 5: Generate Fixes

For each todo item:

1. **Read the file** to understand the current implementation
2. **Understand the context** by reading related files if needed
3. **Generate the fix** following the project's conventions:
   - Follow the coding style in CLAUDE.md and CONVENTIONS.md
   - Use appropriate state management (Redux/Zustand/Jotai/React Query)
   - Follow TypeScript best practices
   - Maintain consistency with existing patterns
4. **Use Edit tool** to apply changes
5. **Mark the todo as completed**

### Step 6: Present Changes for Review

After generating all fixes:

1. Show a summary of all changes made:
   - List of files modified
   - Brief description of each change
   - Which PR comment each change addresses

2. Run type checking and linting to verify:
   ```bash
   yarn tsc && yarn lint
   ```

3. Ask the user to review the changes:
   - Show git diff for verification
   - Ask if they want to:
     - Accept all changes and create a commit
     - Make manual adjustments first
     - Discard specific changes

### Step 7: Create Commit (if approved)

If the user approves the changes:

1. Stage the modified files:
   ```bash
   git add [modified-files]
   ```

2. Create a descriptive commit message that references the PR:
   ```bash
   git commit -m "$(cat <<'EOF'
   fix: address PR #[PR-number] review comments

   - Fix type error in Balance component
   - Refactor useTokenBalance hook
   - Add error handling to swap function
   - Update JSDoc comments

   Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
   EOF
   )"
   ```

3. Ask if the user wants to push:
   ```bash
   git push
   ```

## Important Notes

- **Always read files before editing** - Never propose changes to code you haven't seen
- **Follow project conventions** - Use the patterns documented in CLAUDE.md
- **Use TodoWrite proactively** - Create a clear task list before starting
- **Test before committing** - Run `yarn tsc && yarn lint` to verify changes
- **Let user review first** - Never commit without explicit approval
- **Reference the PR** - Include PR number in commit message
- **Handle merge conflicts** - If the branch is behind, ask user to update first

## Error Handling

If GitHub CLI commands fail:
- Check if user is authenticated: `gh auth status`
- Verify PR exists: `gh pr list`
- Ensure correct repository context

If no comments found:
- Inform the user and ask if they want to proceed with general improvements
- Suggest running `/review-pr` instead for a fresh AI review

## Integration with Other Tools

This skill works well with:
- `/review-pr` - For AI-powered PR review before addressing comments
- `/commit` - For creating commits after manual fixes
- `yarn test` - For running tests after applying fixes
