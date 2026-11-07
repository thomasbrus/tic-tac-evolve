---
name: code-quality
description: "Verify Genesis iteration work before commit. Use after every /next iteration, when checking code quality, or before committing the games gem. Runs the project checks and reviews the diff."
argument-hint: "Optional path to review"
---

# Code quality

Verify the work of the current Genesis iteration before committing it.
Do not edit `.github/prompts/next.prompt.md`. Do not push.

## When to use

- The expert runs `/next` and the iteration changed code, checks, or this skill.
- The expert asks to verify, review, or check code quality.
- Immediately before the iteration commit required by ledger D3.

## Procedure

1. From the repository root, run [verify.rb](./scripts/verify.rb).
   If it exits non-zero, fix the failure in this iteration and run it again.
   Do not commit a failing run.
2. Read the diff for this iteration. Fail the review if any of these are true:
   - A behavior change has no matching check change.
   - The log claims a command that was not run.
   - A generated `player1.view`, `player2.view`, or `*.gem` is staged.
   - A secret, license, homepage, or email was invented.
   - The prompt file was edited.
3. Style nits are not failures. Record real failures in `genesis/log.md`
   before the commit. A clean script run is not a review of product rules.
