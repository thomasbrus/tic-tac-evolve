# Ruby guidelines

Evolvable rules for the `games` gem. This file is the code-quality bar.
It covers project structure and classes, not line-by-line style.

Change a rule here when the expert corrects it. Do not add a rule they
have not agreed unless it is marked as an assumption.

## How a rule changes

- An expert correction in chat becomes a ledger Decision, then a change
  to the matching section below.
- An assumption stays labeled until the expert agrees or overrules it.
- Do not add a linter, a formatter, or a line-length rule to stand in
  for a missing guideline.

## Project structure

Agreed:

- The gem is named `games`. Game code lives under `lib/games/`.
- Each game is a folder: `lib/games/<game>/`. Stratego is
  `lib/games/stratego/`.
- The repository root is not the game. `stratego.rb` is only the launcher.
- Checks stay at the repository root until a later rule moves them.
- The Genesis ledger and the `/next` prompt are not part of the gem.

## Classes

Not agreed. The current code is `module Games::Stratego` with module
functions and no classes. Do not invent a class rule, and do not
rewrite that module, until the expert answers Q7.

## Not this

A passing syntax check or a passing `gem build` is not code quality.
`check_board.rb` and `check_army.rb` still lock behavior. They do not
replace this file.
