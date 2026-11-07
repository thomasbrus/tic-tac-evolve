# Log

Append-only. One entry per `/next` iteration.

## 2026-11-07 — 1

Bootstrapped state. Repo contained only
`.github/prompts/next.prompt.md`. Created this log and `ledger.md`, seeded
from that prompt with every product decision left open.

- L4: ledger and log now exist and point at the prompt.
- L0–L3: unchanged; no artifacts.
- Ripple: a subject decision (Q1) is required before any lower-level artifact.
  Recorded A2 as the skip path. Did not edit the prompt.
- Verified: re-read both files against the prompt's required sections.
  Did not run tests (none exist). Did not commit.
- Before handback, the expert answered Q1 with B. Recorded D1, retired A2,
  opened Q2. Ripple: L0–L3 still empty until the domain is chosen. Did not
  start the domain question; that is the next iteration.

## 2026-11-07 — 2

Asked Q2. No other unblocked step: D1 requires a product, and the repo still
has no domain evidence. Did not invent a language, user, or architecture.

- L4: marked Q2 asked; recorded skip path A3.
- L0–L3: unchanged.
- Ripple: a domain answer will force the first L0 slice and an L1 brief.
  Until then, nothing propagates.
- Verified: re-read the ledger sections. Did not run tests (none exist).
  Did not commit. Did not edit the prompt.
- Before handback, the expert answered Q2: "ruby stratego game with a cli
  ui". Recorded D2, retired A3, opened P1 and A4. Ripple: L0 will be Ruby,
  L1 a brief for that code, L2 checks for that CLI. Did not write code.

## 2026-11-07 — 3

Recorded D3 from the steering hint "also ensure that we git commit after
every iteration". Did not edit the prompt. Parked Q3. Carried out A4.

- L0: added [stratego.rb](../stratego.rb). Empty 10×10 board, lakes at
  c5–d6 and g5–h6, then exit. No pieces, moves, or opponent.
- L1: still no brief. The slice was written at L0 by this loop.
- L2: no committed check. Verified by running `ruby stratego.rb` and a
  one-off assertion: 10×10, 8 lakes, CLI output matches `render_board`.
- L3: no evaluation.
- L4: D3 authorizes a commit after this iteration. Repo was not a git
  repository; `git init` is required to carry out D3. No push.
- Ripple: A5 is the only new downward choice. Rules fidelity is still open,
  so the lakes stay an assumption. Q3 does not block the next slice.

## 2026-11-07 — 4

Committed the board check promised at the end of iteration 3. The expert
did not overrule that step. Did not add pieces. Did not edit the prompt.

- L0: unchanged.
- L2: added [check_board.rb](../check_board.rb). It encodes A5 as a fixture
  and checks `render_board` plus the CLI exit and stdout.
- L1 and L3: unchanged.
- L4: opened Q4, not asked. Pieces are blocked on it.
- Verified: `ruby check_board.rb` printed `ok` and exited 0. A one-off copy
  that moved lake c5 to c4 failed with `render_board drifted from A5` and
  exited 1. That copy was not committed.
- Ripple: the check now fails if A5 changes, so a rules decision has to
  update L0 and L2 together. No push. Commit follows under D3.

## 2026-11-07 — 5

Asked Q4. No unblocked product step: pieces, moves, and opponents need a
ruleset, and inventing one would promote A5's source into a Decision.

- L0–L3: unchanged. Did not edit [stratego.rb](../stratego.rb) or
  [check_board.rb](../check_board.rb).
- L4: marked Q4 asked. Recorded skip path A6. Q3 stays parked.
- Verified: re-read the Q4 ledger entry. Did not run `ruby check_board.rb`
  because no code changed. Did not edit the prompt. No push.
- Ripple: a ruleset answer will have to update the board check if it moves
  the lakes, and will unblock the first piece slice. Until then, nothing
  propagates.
- Before handback, the expert answered Q4 with A. Recorded D4, retired A6,
  adopted the A5 lakes into that ruleset, opened Q5 and P3. Did not add
  pieces. A7 is the next slice unless overruled.

## 2026-11-07 — 6

Carried out A7. The expert did not overrule it. Added the D4 piece counts
and a check that they total 40. No placement, movement, combat, or hiding.
Did not ask Q5. Did not edit the prompt.

- L0: `ARMY` and `army_size` in [stratego.rb](../stratego.rb). CLI output
  unchanged.
- L2: [check_army.rb](../check_army.rb) encodes the D4 counts independently.
- L1 and L3: unchanged.
- Verified: `ruby check_board.rb` and `ruby check_army.rb` each printed `ok`
  and exited 0. A one-off copy with 7 scouts failed `check_army` on counts
  and exited 1. That copy was not committed.
- Ripple: the counts are now locked the same way the lakes are. Q5 still
  blocks play. A8 is the next slice unless overruled. No push.

## 2026-11-07 — 7

Carried out A8. The expert did not overrule it. The CLI now prints the
inventory under the board. No placement, movement, combat, or hiding.
Did not ask Q5. Did not edit the prompt.

- L0: `render_inventory` and `render_cli` in [stratego.rb](../stratego.rb).
  Layout is A9: one `name count` line per piece, after a blank line.
- L2: [check_board.rb](../check_board.rb) locks that CLI text and still
  checks the lakes. [check_army.rb](../check_army.rb) unchanged.
- L1 and L3: unchanged.
- Verified: `ruby stratego.rb` printed the board and the 12 inventory
  lines. `ruby check_board.rb` and `ruby check_army.rb` each printed `ok`
  and exited 0. A one-off copy that changed the inventory separator failed
  with `render_inventory drifted` and exited 1. That copy was not committed.
- Ripple: A9 is the only new choice, and it is display, not rules. Q5 still
  blocks play. The next iteration asks Q5. No push.

## 2026-11-07 — 8

Asked Q5. Setup and play stay blocked until a hiding mechanism is chosen.
Did not change [stratego.rb](../stratego.rb). Did not edit the prompt.

- L0–L3: unchanged.
- L4: marked Q5 asked. Recorded skip path A10. Q3 stays parked.
- Verified: re-read the Q5 entry. Did not run the checks because no game
  code changed. No push.
- Ripple: the answer chooses the first setup slice. A screen-clear handoff,
  an open board, and a second private view are different L0 and L2 work.
- Before handback, the expert answered Q5 with C. Recorded D5. Retired A10.
  A11 assumes a file per player for the next slice, not a second terminal.
  Did not write files or setup code.

## 2026-11-07 — 9

The expert ran `./stratego.rb`. It was not executable, and after `chmod +x`
zsh treated the Ruby as a shell script. Recorded D6. Deferred A11.

- L0: added `#!/usr/bin/env ruby` and kept the executable bit.
- L2: [check_board.rb](../check_board.rb) now runs the file directly and
  compares that output with `ruby stratego.rb`.
- L3: the pasted zsh error is the evidence. No separate evaluation file.
- L1 and L4: no prompt edit. A11 remains the next product slice.
- Verified: `./stratego.rb` exited 0. `ruby check_board.rb` and
  `ruby check_army.rb` each printed `ok`. A one-off executable copy with
  the shebang removed failed with `direct exit 2` and the same zsh syntax
  error. That copy was not
  committed. No push.

## 2026-11-07 — 10

Carried out A11. The expert did not overrule it. Did not add a second
terminal, placement, movement, or combat. Did not edit the prompt.

- L0: `./stratego.rb` writes `player1.view` and `player2.view` in the
  current directory. Each file is that player's unplaced army in the A9
  layout. Shared stdout is unchanged. A12 names the files.
- L2: [check_board.rb](../check_board.rb) runs the CLI in a temp directory
  and rejects a view that is not only the army. [.gitignore](../.gitignore)
  keeps generated views out of commits.
- L1 and L3: unchanged.
- Verified: `ruby check_board.rb` and `ruby check_army.rb` each printed
  `ok`. A temp run wrote both files and no others. A one-off copy whose
  private view included the board failed with `player1.view is not only
  the army` and exited 1. That copy was not committed.
- Ripple: the two files are still identical, so privacy is not demonstrated
  yet. A13 is the next slice unless overruled. No push.

## 2026-11-07 — 11

The expert asked to set the project up as a lib/gem named games, with
Stratego as a folder. Recorded D7. Deferred A13. Did not edit the prompt.

- L0: behavior unchanged. Implementation moved to
  [lib/games/stratego/game.rb](../lib/games/stratego/game.rb) as
  `Games::Stratego`. [stratego.rb](../stratego.rb) is now the D6 launcher.
- L2: added [games.gemspec](../games.gemspec). No license, homepage, or
  email. A14 records those choices.
- L1, L3, L4: no prompt edit.
- Verified: `./stratego.rb` exited 0 and the generated views were removed.
  `ruby check_board.rb` and `ruby check_army.rb` each printed `ok`.
  `gem build games.gemspec` built `games-0.1.0.gem`. RubyGems warned that
  no homepage is specified. The built gem was not committed.
- Ripple: checks now load `lib/games` instead of the launcher. A13 is still
  the next product slice unless overruled. No push.

## 2026-11-07 — 12

The expert asked for a code-quality skill to verify our work after every
iteration. Recorded D8. Deferred A13. Did not edit the prompt. Parked Q6.

- L2: added the workspace skill and [verify.rb](../.github/skills/code-quality/scripts/verify.rb).
  A15 places it in the repo, not the user profile.
- L0, L1, L3: unchanged.
- Verified: `ruby .github/skills/code-quality/scripts/verify.rb` printed `ok`.
  A one-off copy with a syntax error in `lib/games.rb` failed `ruby -c` and
  exited 1. That copy was not committed. Diff review: this iteration adds
  the skill only, so no product behavior changed without a check. No view
  file or gem is staged. No license, homepage, or email was invented. The
  prompt was not edited.
- Ripple: future iterations must run the skill before commit. Q6 is the
  only prompt change, and it is parked. A13 remains the next product slice
  unless overruled. No push.
