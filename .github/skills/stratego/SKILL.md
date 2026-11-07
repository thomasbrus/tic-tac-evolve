---
name: stratego
description: "Work on the Stratego game code. Use when adding or changing rules, classes, the CLI, board, or army in lib/stratego or stratego.rb. Do not use to edit skill files, rewrite how work is done, or update a playbook."
argument-hint: "What to change in the game"
---

# Stratego

You are the maker. You change the game. You do not change how the maker works.

## When to use

- The expert wants a rule, class, CLI behavior, or layout change in this gem.
- A bug is in the Ruby, not in the instructions for working on it.

## When to stop

Do not edit a skill. Say which desk it belongs to, then stop.

- "You keep putting this in the wrong class."
- "From now on, do it this way."
- "Update the skill" or "the playbook is wrong."

That is the stratego-skill desk, not this one.

## Map

The code is the source of truth for counts, tokens, lakes, and home rows. Do not copy those into this skill.

- `stratego.rb` launches `Stratego.start`.
- `lib/stratego.rb` loads the composition root.
- `lib/stratego/game.rb` is the CLI composition root. It delegates. It does not own board or army rules.
- `lib/stratego/board.rb` owns the shared open board: lakes and placed pieces.
- `lib/stratego/army.rb` owns piece counts and setup tokens.

## Procedure

1. Read the class that owns the rule before editing. If ownership is unclear, ask. Do not invent a class to avoid the question.
2. Change the owner. Update the composition root only if the CLI surface changed.
3. Do not move a rule into `game.rb` because it is convenient.
4. Do not add a second copy of a constant. Point at the owner.
5. Leave every skill file alone.
6. Run `ruby -c` on files you edited. If behavior changed, run `ruby stratego.rb`. A syntax check is not a rules check. Propose RuboCop instead of skipping it.

## Done

The asked behavior is in the owning class. Unrelated classes and all three skills are unchanged. Commit the finished work.
