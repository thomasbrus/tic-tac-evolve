---
name: code-quality
description: "Evolving guidelines for Ruby project structure and classes in the games gem. Use when writing or reviewing Ruby here, when changing lib/ layout, or when the expert asks about code quality, classes, or structure. Not a line-by-line linter."
argument-hint: "Optional file or rule to evolve"
---

# Code quality

Apply and evolve the Ruby guidelines. Do not edit
`.github/prompts/next.prompt.md`. Do not push.

## When to use

- Writing or moving Ruby in this repository.
- The expert asks about code quality, project structure, or classes.
- Before the iteration commit, if that iteration touched Ruby or these
  guidelines.

## Procedure

1. Read [guidelines.md](./references/guidelines.md).
2. If the iteration conflicts with an agreed rule, fix that conflict or
   record why it remains.
3. If it conflicts with an open section, do not refactor the game to
   invent the missing rule.
4. When the expert corrects a guideline, update `guidelines.md` in this
   iteration and record the Decision in the ledger. Do not add a rule
   they did not ask for.
5. If Ruby behavior changed, run `ruby check_board.rb` and
   `ruby check_army.rb`. This skill does not replace those checks.
