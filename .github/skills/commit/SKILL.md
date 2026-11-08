---
name: commit
description: "Commit requested Git changes as one or more coherent commits. Use when asked to commit or split changes, or invoked as /commit."
argument-hint: "Optional scope or desired commit groupings"
user-invocable: true
---

# Commit changes

Keep this a commit workflow, not a fresh code review. Large changes need concise file or directory summaries, not exhaustive analysis.

1. Start with `git status --short`, `git diff --stat`, and `git diff --cached --stat`. Reuse known context and summarize what changed. Read only targeted diffs or untracked files needed to clarify scope, write an accurate message, or check for unrelated changes and secrets. Do not dump full diffs just because the change is large.
2. Default to one commit for the requested scope. Split only when requested or when independent groups are obvious from the file summary. Keep related implementation, tests, and documentation together. Ask only when scope or grouping is genuinely unclear.
3. Preserve unrelated work and existing staging. Ask before altering existing staging or including it in a different commit. Stage explicit paths; use selective hunks only when necessary, and ask if they cannot be separated safely. Never reset, stash, overwrite, or discard work to simplify a commit.
4. Verify the staged file list and summary match the intended scope, and run `git diff --cached --check`. Inspect specific staged hunks only where scope or risk warrants it.
5. Reuse completed checks when the tested contents have not changed. Run only missing checks required by the changed surface; do not create isolated snapshots or test every intermediate commit by default. If remaining work affects a required check, verify the exact staged contents or report the limitation. State what was actually tested and stop on failures.
6. Follow [project message conventions](../../copilot-instructions.md#commit-messages): use an accurate past-tense subject and no Copilot authorship trailers. Ask for confirmation if a supplied message violates these rules. Create commits without amending or rewriting history unless explicitly requested.
7. Check the resulting commit and working-tree status. Report the hash and subject, checks run or reused, and remaining changes briefly. If a commit fails, stop and report what succeeded and what remains.
