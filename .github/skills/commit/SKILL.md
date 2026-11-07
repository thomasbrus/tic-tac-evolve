---
name: commit
description: "Commit requested Git changes as one or more coherent commits. Use when asked to commit or split changes, or invoked as /commit."
argument-hint: "Optional scope or desired commit groupings"
user-invocable: true
---

# Commit changes

1. Inspect the working tree, staged and unstaged diffs, and relevant untracked files. Establish the intended scope; ask if it is unclear. Never include unrelated changes or secrets.
2. Plan one commit for a cohesive change, or multiple commits when changes separate naturally into meaningful, independently coherent groups. Keep related implementation, tests, and documentation together where practical, and order prerequisites first. Respect explicit grouping requests; ask if the split or ordering is ambiguous rather than forcing it.
3. Preserve existing staged and unstaged work outside the requested scope. If changes are already staged, inspect them and ask before altering their staging or including them in a different commit. Do not reset, stash, overwrite, or discard work to make splitting easier.
4. Stage one group at a time. When a file contains changes for multiple commits, stage only the intended hunks using a safe selective staging method; if the changes cannot be separated safely, ask the user rather than including unrelated work. Review the complete staged diff before every commit.
5. Run relevant checks against each commit's contents when feasible, using an isolated snapshot if the remaining working tree would affect the results. If a check cannot be run against that snapshot, state what was actually tested; do not imply that testing the full working tree verified intermediate commits. Stop and report failures or blockers rather than hiding them.
6. Follow the project commit-message conventions and create each commit without amending or rewriting existing history. If a commit or check fails, stop and report the commits already created and the remaining work.
7. Verify the resulting commit sequence and working-tree status. Report each commit's identifier and subject, the checks performed, and any remaining changes.
