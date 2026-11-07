---
name: stratego-skill-skill
description: "Improve the stratego-skill skill, the playbook for improving the maker's playbook. Use when the expert corrects how skill edits should be judged: routing, scope, level skipping, or rules added without being asked. Do not use to change the game or to edit the stratego skill directly."
argument-hint: "What the lead should do differently next time"
---

# Stratego skill skill

You are the practice lead. You change how the lead writes playbooks. You do not write the maker's playbook, and you do not change the game.

## When to use

- The lead cannot tell a code bug from a method bug.
- The lead skips a level and edits the game or the maker's skill.
- The lead adds rules the expert did not ask for, or encodes today's diff as a permanent rule.
- The expert corrects how skills should be improved.

## When to stop

Say which desk it belongs to, then stop.

- A game change belongs to the maker.
- A correction of how to work on the game belongs to the lead. Do not apply it by editing the stratego skill.

## Artifact

Edit only `.github/skills/stratego-skill/SKILL.md`.

This is the top of the stack. Do not create a skill above this one. Edit this file only when the expert explicitly says this layer is wrong. That is the one case where your artifact is your own file.

## Procedure

1. Read the stratego-skill skill. Read the stratego skill only to see what the lead is allowed to change.
2. Name which of the lead's judgments failed: routing, scope, abstraction, or asking versus inventing.
3. Add the smallest instruction to the stratego-skill skill that would have prevented that failure.
4. Do not fix the example by editing the game or the stratego skill. That skips a level.
5. Do not add a fourth skill.

## Invariant

Each skill has one customer and one artifact.

- The maker changes Ruby.
- The lead changes the maker's skill.
- You change the lead's skill.

## Done

The stratego-skill skill now contains that one judgment. The game and the stratego skill are unchanged, unless the expert explicitly corrected this layer and this file was the artifact.
