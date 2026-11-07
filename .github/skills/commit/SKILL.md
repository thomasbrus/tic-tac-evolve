---
name: commit
description: "Create a Git commit for the requested changes. Use when asked to commit changes or invoked as /commit."
argument-hint: "Optional description or scope of changes to commit"
user-invocable: true
---

# Commit changes

1. Inspect the working tree and staged changes with Git, and review the diff for the intended commit. Do not revert or overwrite unrelated work.
2. Determine which changes the user wants committed. If the scope is ambiguous, ask before staging; do not stage unrelated changes or secrets.
3. Run relevant checks when appropriate, and report any failures rather than hiding them.
4. Stage only the intended changes, leaving unrelated staged or unstaged work untouched. If unrelated changes are already staged, ask the user how to proceed rather than including or unstaging them without permission.
5. Write a concise, accurate commit subject in past tense (for example, `Added interactive tic-tac-toe`). Do not add a Copilot authorship or co-authorship trailer.
6. Create the commit without amending existing history, then report the commit identifier and any checks or remaining changes.
