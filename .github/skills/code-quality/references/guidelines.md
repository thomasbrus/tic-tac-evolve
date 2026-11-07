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

Agreed:

- Stratego is split into `Games::Stratego::Board`, `Games::Stratego::Army`,
  and `Games::Stratego::View`.
- `Games::Stratego` stays the namespace and the CLI composition root. It
  does not own the board, army, or view rules.
- A new game gets its own folder and its own classes. Do not put another
  game's rules in Stratego's classes.
- Do not add a class with no named responsibility. These three are the
  current split.

## Not this

A passing syntax check or a passing `gem build` is not code quality.
`check_board.rb` and `check_army.rb` still lock behavior. They do not
replace this file.
