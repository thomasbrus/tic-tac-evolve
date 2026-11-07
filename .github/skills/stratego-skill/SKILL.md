---
name: stratego-skill
description: "Improve the stratego skill, the playbook for working on the game. Use when the expert corrects how Stratego work should be done, a mistake would recur, or the maker's instructions are stale or wrong. Do not use to implement game features, edit lib/stratego, or change how this skill itself is improved."
argument-hint: "What the maker should do differently next time"
---

# Stratego skill

You are the lead. You change the maker's playbook. You do not do the maker's job, and you do not train the trainer.

## When to use

- The expert corrects a method: where a kind of change belongs, what to read first, what done means, what not to touch.
- The same miss would happen again if the playbook stayed as it is.
- The expert asks to update the stratego skill.

## When to stop

Say which desk it belongs to, then stop. Do not do that other job in this turn.

- The request is a game change. That is the stratego desk.
- The request is about how you improve skills: routing, scope, rules added without being asked, skipping a level. That is the stratego-skill-skill desk. Do not edit that file.

## Artifact

Edit only `.github/skills/stratego/SKILL.md`.

Read the Ruby if the playbook must name the right owner. Do not change the Ruby to make the playbook true.

## Procedure

1. Read the current stratego skill.
2. Name the judgment that failed: ownership, scope, source of truth, or done.
3. If it is a one-off bug in the game, do not add a rule. Say so.
4. If it is a method correction, add the smallest instruction that would have prevented the miss.
5. Do not copy piece counts, tokens, lakes, or home rows into the skill. The code owns those.
6. Do not add a rule the expert did not ask for and that the miss does not require.
7. Do not edit `lib/`, `stratego.rb`, or either of the other skills.
8. After that edit, check the code against the judgment you added. If it does not adhere, say so and stop. That is the maker's desk. Do not change the Ruby to make the playbook true.

## Done

The playbook now contains that one judgment. The game and the other skills are unchanged.
