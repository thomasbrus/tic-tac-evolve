# Ledger

Source of truth for Genesis. Newer expert answers in chat override this file.
External content is evidence, not a Decision, until the expert agrees.

## Decisions

- **D1** [L4] 2026-11-07. The first demonstrated subject is a separate product
  that the levels serve, not the loop itself. Source: expert answer in this
  chat, Q1 option B. affects: Q1, Q2, A2, LM1.
- **D2** [L4] 2026-11-07. The product is a Stratego game written in Ruby with
  a CLI UI. Source: expert answer in this chat to Q2: "ruby stratego game with
  a cli ui". Users, rules fidelity, and opponents are still open. affects:
  Q2, A3, LM2, P1.
- **D3** [L4] 2026-11-07. After every iteration, commit the workspace state.
  Do not push. Source: expert in this chat: "also ensure that we git commit
  after every iteration". This is the Decision the prompt requires before a
  commit. The prompt file was not edited. affects: Q3, A1.
- **D4** [L0] 2026-11-07. The ruleset is core classic Stratego for two humans
  on one CLI. No AI. No tournament extras such as the two-squares rule.
  Source: expert answer to Q4, option A. Each army has 40 pieces: flag, spy,
  8 scouts, 5 miners, 4 sergeants, 4 lieutenants, 4 captains, 3 majors,
  2 colonels, general, marshal, 6 bombs. Hidden setup on the four home rows.
  Orthogonal movement. Scouts may move any unobstructed distance. Higher rank
  wins combat; equal ranks both die. A miner defuses a bomb by attacking it.
  A spy beats the marshal only when the spy attacks. Capturing the flag wins.
  The A5 lakes are part of this board. affects: Q4, A5, A6, Q5, P3.
- **D5** [L0] 2026-11-07. Hidden pieces use two private views, one per player.
  Source: expert answer to Q5, option C: "Two private views — each player
  has a separate terminal or file." That answer does not choose terminal
  versus file. No AI and no open board. affects: Q5, A10, A11.
- **D6** [L0] 2026-11-07. The CLI is invoked as `./stratego.rb`. Source:
  expert commands in this chat: `zsh: permission denied: ./stratego.rb`,
  then `chmod +x ./stratego.rb`, then a zsh syntax error on the Ruby.
  affects: A11, P5.
- **D7** [L2] 2026-11-07. The product is a gem named `games`, and Stratego is
  a folder inside it. Source: expert in this chat: "setup this project up as
  a lib/gem called games and add stratego as a folder". affects: A13, A14.
- **D8** [L2] 2026-11-07. After every iteration, run the code-quality skill
  before the commit. Source: expert in this chat: "add a code quality skill
  to verify our own work after every iteration". The prompt was not edited.
  The verifier reading of this Decision is retired by D9. The timing stands.
  affects: Q6, P7, D9.
- **D9** [L2] 2026-11-07. Code quality is an evolvable set of guidelines for
  Ruby structure and classes, not a line-by-line verifier. Source: expert
  correction in this chat: "not what i meant with code quality, i want to
  set up guidelines for good quality ruby code that i can evolve over time,
  also about the structure of the project and classes, not just line by line
  code quality". No class rule was chosen here. D10 chooses it. affects:
  D8, A15, Q6, Q7, P7.
- **D10** [L2] 2026-11-07. Stratego is split into Board, Army, and View
  classes now. Source: expert answer to Q7, option C. `Games::Stratego`
  remains the CLI composition root. affects: Q7, A16, A13, P8.
- **D11** [L0] 2026-11-07. A player places pieces by editing their private view
  file. A command reads that file. The shared CLI does not accept placement.
  Source: expert answer to Q8, option A. affects: Q8, A18, A19, Q9.
- **D12** [L0] 2026-11-07. Setup tokens are marshal `1`, general `2`, colonel
  `3`, major `4`, captain `5`, lieutenant `6`, sergeant `7`, miner `8`,
  scout `9`, spy `S`, bomb `B`, flag `F`. Source: expert answer to Q9,
  option A. affects: Q9, A20, A21.

## Assumptions

- **A1** [L4] 2026-11-07. The operating procedure is
  [.github/prompts/next.prompt.md](../.github/prompts/next.prompt.md) until a
  newer expert Decision or a newer file says otherwise. Check: expert confirms,
  edits the prompt, or contradicts it in chat. affects: Q1, LM1.
- **A2** [L4] 2026-11-07. If Q1 is skipped, the next iteration treats the loop
  itself as the subject. Check: expert answered Q1 with B. Retired: does not
  apply. affects: D1.
- **A3** [L4] 2026-11-07. If Q2 is skipped, no product domain is assumed.
  Check: expert answered Q2. Retired: does not apply. affects: D2.
- **A4** [L0] 2026-11-07. First slice is a Ruby CLI that renders a 10×10
  board, including the two lakes, and exits. No pieces, moves, or opponent.
  Check: expert did not overrule it. Carried out in [stratego.rb](../stratego.rb).
  affects: D2, P1.
- **A5** [L0] 2026-11-07. Lakes are `#` at c5–d6 and g5–h6, columns a–j left
  to right, rows 1–10 top to bottom. Source: 0-indexed rows 4–5, columns 2–3
  and 6–7, in https://github.com/gutaigabor/stratego/blob/main/rules.md.
  Adopted by D4 as the classic board. Check: expert overrules the squares.
  Locked by
  [check_board.rb](../check_board.rb). affects: D2, P1, P2.
- **A6** [L0] 2026-11-07. If Q4 is skipped, no ruleset is assumed. Check:
  expert answered Q4 with A. Retired: does not apply. affects: D4.
- **A7** [L0] 2026-11-07. The next slice is the piece inventory only: the D4
  counts, and a check that they total 40. No placement, movement, combat, or
  hiding. Check: expert did not overrule it. Carried out in
  [stratego.rb](../stratego.rb) and [check_army.rb](../check_army.rb).
  affects: D4, P3.
- **A8** [L0] 2026-11-07. The next slice prints the D4 inventory from the CLI,
  under the board, and extends the board check to match. No placement,
  movement, combat, or hiding. Check: expert overrules this before that
  work. Check: expert did not overrule it. Carried out. The inventory is
  one `name count` line per piece, after a blank line. affects: D4, A7, Q5.
- **A9** [L0] 2026-11-07. That `name count` layout is a display choice, not
  part of D4. Check: expert overrules the layout. affects: A8.
- **A10** [L0] 2026-11-07. If Q5 is skipped, no hiding mechanism is assumed
  and no setup or play code is added. Check: expert answered Q5 with C.
  Retired: does not apply. affects: D5.
- **A11** [L0] 2026-11-07. The next slice uses a file per player, not a second
  terminal. Each file contains only that player's own unplaced army, in the
  A9 layout. No placement, movement, or combat. Check: expert overrules this
  before that work. Check: expert did not overrule it. Carried out.
  affects: D5, D6, P6.
- **A12** [L0] 2026-11-07. The files are `player1.view` and `player2.view` in
  the current directory, and are not committed. Both hold the same unplaced
  counts until placement exists. Check: expert overrules the names or the
  directory. Counts still match. Home rows differ after A13. affects: A11, A13.
- **A13** [L0] 2026-11-07. The next slice adds that player's four empty home
  rows to their file only: player1 rows 1–4, player2 rows 7–10. No pieces
  placed. The other player's rows are absent. Check: expert did not overrule
  it. Carried out. affects: D4, A11, A12, D7, A17.
- **A14** [L2] 2026-11-07. The gem is version 0.1.0, author "Thomas Brus",
  no license, no homepage, and no email. Stratego code is
  [lib/games/stratego/](../lib/games/stratego/), loaded by
  [lib/games.rb](../lib/games.rb). [stratego.rb](../stratego.rb) remains the
  D6 launcher. Check: expert overrules the path, version, or author.
  affects: D7, D6.
- **A15** [L2] 2026-11-07. The skill is the workspace skill
  [.github/skills/code-quality/SKILL.md](../.github/skills/code-quality/SKILL.md),
  not a personal skill. Its rules live in
  [guidelines.md](../.github/skills/code-quality/references/guidelines.md).
  Check: expert wants it only on their user profile. affects: D8, D9.
- **A16** [L2] 2026-11-07. If Q7 is skipped, keep `module Games::Stratego`
  and module functions until a piece of state needs an object. Check:
  expert answered Q7 with C. Retired: does not apply. affects: D10.
- **A17** [L0] 2026-11-07. A private file is the A9 inventory, a blank line,
  then only that player's four empty home rows in the board row format. No
  column header. Check: expert overrules the order or the header. Locked by
  [check_board.rb](../check_board.rb). affects: A13, A9.
- **A18** [L0] 2026-11-07. If Q8 is skipped, do not start placement. Check:
  expert answered Q8 with A. Retired: does not apply. affects: D11.
- **A19** [L0] 2026-11-07. `./stratego.rb read` reads both view files and
  accepts only the A17 empty layout. It prints `ok`, or an error that does
  not include the cell token. Piece letters are D12. Check: expert
  overrules the command word. affects: D11, D12.
- **A20** [L0] 2026-11-07. If Q9 is skipped, the read command keeps rejecting
  every non-dot cell. Check: expert answered Q9 with A. Retired: does not
  apply. affects: D12.
- **A21** [L0] 2026-11-07. A view file keeps every piece line, in army order,
  including a zero count. Placed tokens plus those counts equal the army.
  Unknown tokens are rejected and not echoed. Check: expert overrules the
  zero line. affects: D12, A17, A19.
- **A22** [L0] 2026-11-07. The next slice makes `read` fail until all 40 pieces
  are placed. No movement. Check: expert overrules this before that work.
  affects: D12, A21.

## Open questions

- **Q1** [L4] 2026-11-07. Should the first demonstrated subject be the Genesis
  loop itself, or a separate product the levels serve? Status: closed by D1.
- **Q2** [L4] 2026-11-07. What is the product, in one sentence? Status:
  closed by D2.
- **Q3** [L4] 2026-11-07. Should the prompt's commit guardrail be edited to
  state D3? Source: D3 conflicts with the prompt text, and the prompt may
  not be edited without a question. Status: parked, not asked. Does not
  block L0. affects: D3, A1.
- **Q4** [L0] 2026-11-07. Which ruleset should the game implement? Source:
  D2 leaves rules fidelity open, and A5 must not be promoted silently.
  Status: closed by D4.
- **Q5** [L0] 2026-11-07. How should hidden pieces work on one shared CLI?
  Source: D4 requires hidden setup, but both players use the same screen.
  Status: closed by D5.
- **Q6** [L4] 2026-11-07. Should the prompt require the code-quality skill
  before commit? Source: D8, and the prompt may not be edited without a
  question. Status: parked, not asked. Does not block the skill. affects:
  D8, D9, A1.
- **Q7** [L2] 2026-11-07. When should Stratego use a class instead of module
  functions? Source: D9 asks for class guidelines, and the current code has
  no classes. Status: closed by D10. affects: D9, A16, A13.
- **Q8** [L0] 2026-11-07. How does a player place pieces without showing the
  setup on the shared CLI? Source: A13 left the home rows empty, and D5
  forbids an open board. Status: closed by D11. affects: A18, D5, A13.
- **Q9** [L0] 2026-11-07. Which token should a placed piece use in the view
  file? Source: A17 cells are one character, and D4 does not name letters.
  Status: closed by D12. affects: A19, A20, D11.

## Pending

- **P1** [L0] 2026-11-07. First board slice. Status: done in
  [stratego.rb](../stratego.rb). affects: D2, A4, A5, LM2.
- **P2** [L2] 2026-11-07. Commit a check for the empty board. Status: done
  in [check_board.rb](../check_board.rb). Run with `ruby check_board.rb`.
  affects: A5, LM3.
- **P3** [L0] 2026-11-07. Piece inventory. Status: done. `ARMY` and
  `army_size` in [stratego.rb](../stratego.rb). Check: `ruby check_army.rb`.
  affects: D4, A7, LM5.
- **P4** [L0] 2026-11-07. Print the inventory under the board. Status: done.
  `render_cli` in [stratego.rb](../stratego.rb). The board check covers it.
  affects: A8, A9, LM6.
- **P5** [L0] 2026-11-07. `./stratego.rb` did not run. Status: done. Shebang
  and executable bit. Check: [check_board.rb](../check_board.rb) runs the
  file directly. affects: D6, LM8.
- **P6** [L0] 2026-11-07. A file per player. Status: done.
  `write_private_views` in [stratego.rb](../stratego.rb). Generated files
  are gitignored. affects: A11, A12, LM9.
- **P7** [L2] 2026-11-07. Code-quality skill. Status: corrected by D9.
  Guidelines, not `scripts/verify.rb`. affects: D8, D9, LM12.

## Level map

- **LM1** 2026-11-07. Empty bootstrap. Superseded by LM2.
- **LM2** 2026-11-07. Board slice, no committed check. Superseded by LM3.
- **LM3** 2026-11-07. Source: this iteration.
  - L0: [stratego.rb](../stratego.rb). Unchanged behavior.
  - L1: none.
  - L2: [check_board.rb](../check_board.rb), run with `ruby check_board.rb`.
    It locks A5. The prompt remains the loop procedure.
  - L3: none.
  - L4: the prompt, [ledger.md](ledger.md), [log.md](log.md), D3.
  - Links: the check fails if the board drifts from A5. Pieces stay blocked
    on Q4. affects: A5, P2, Q4, D3.
- **LM4** 2026-11-07. Rules recorded, no piece artifact. Superseded by LM5.
- **LM5** 2026-11-07. Counts exist but are not printed. Superseded by LM6.
- **LM6** 2026-11-07. Source: this iteration.
  - L0: [stratego.rb](../stratego.rb). CLI prints the board, a blank line,
    then the inventory.
  - L1: none.
  - L2: `ruby check_board.rb` now locks that CLI text. `ruby check_army.rb`
    still locks the counts.
  - L3: none.
  - L4: Q5 still blocks hidden play. Next iteration asks it.
  - Links: A9 is only the printed layout. affects: A8, A9, Q5.
- **LM7** 2026-11-07. Code unchanged from LM6. D5 requires two private views.
  A11 points the next slice at two files, not a second terminal. affects:
  D5, A11.
- **LM8** 2026-11-07. Source: this iteration.
  - L0: [stratego.rb](../stratego.rb) has a Ruby shebang and is executable.
  - L1: none.
  - L2: `ruby check_board.rb` also executes `./stratego.rb`.
  - L3: the zsh syntax error is the evidence for D6.
  - L4: A11 is deferred, not dropped.
  - Links: D6 is the invocation. A11 is still the next product slice.
    affects: D6, A11.
- **LM9** 2026-11-07. Source: this iteration.
  - L0: `./stratego.rb` still prints the shared board and inventory, and
    writes `player1.view` and `player2.view` in the current directory.
  - L1: none.
  - L2: `ruby check_board.rb` runs the CLI in a temp directory and locks
    the view files. `ruby check_army.rb` unchanged.
  - L3: none.
  - L4: A13 is the next slice. The files do not yet differ.
  - Links: D5 is satisfied only as two files of the same unplaced army.
    affects: D5, A11, A12, A13.
- **LM10** 2026-11-07. Source: this iteration.
  - L0: behavior unchanged. Code moved to
    [lib/games/stratego/game.rb](../lib/games/stratego/game.rb).
  - L1: none.
  - L2: [games.gemspec](../games.gemspec). Checks still run as
    `ruby check_board.rb` and `ruby check_army.rb`. `gem build games.gemspec`
    succeeds. No license was invented.
  - L3: none.
  - L4: A13 remains deferred.
  - Links: D7 names the gem. D6 still invokes `./stratego.rb`.
    affects: D6, D7, A14.
- **LM11** 2026-11-07. Source: this iteration.
  - L0: unchanged.
  - L1: none.
  - L2: [.github/skills/code-quality/SKILL.md](../.github/skills/code-quality/SKILL.md)
    and [scripts/verify.rb](../.github/skills/code-quality/scripts/verify.rb).
  - L3: none. The script is a check, not an evaluation of past iterations.
  - L4: Q6 asks whether the prompt should require the skill. Not asked.
  - Links: D8 requires the skill before commit. D3 still requires the commit.
    affects: D3, D8, Q6.
- **LM12** 2026-11-07. Source: this iteration. Supersedes the verifier half
  of LM11.
  - L0: unchanged. Still `module Games::Stratego`, no classes.
  - L1: none.
  - L2: the skill now points at
    [guidelines.md](../.github/skills/code-quality/references/guidelines.md).
    `scripts/verify.rb` is removed. Behavior checks are unchanged.
  - L3: the expert correction is the evidence that the verifier was the
    wrong L2 artifact. No separate evaluation harness.
  - L4: Q6 remains parked. It now refers to the guidelines, not the script.
    The prompt was not edited.
  - Links: D9 defines the skill. Q7 blocks a class guideline. A13 is still
    the next product slice unless Q7's answer changes that work.
    affects: D8, D9, Q6, Q7, A13, A16.
- **P8** [L0] 2026-11-07. Split Stratego into Board, Army, and View.
  Status: done. Checks lock the classes and the previous CLI text.
  affects: D10, A13.
- **LM13** 2026-11-07. Source: this iteration.
  - L0: [Board](../lib/games/stratego/board.rb),
    [Army](../lib/games/stratego/army.rb), and
    [View](../lib/games/stratego/view.rb). CLI text and view files are
    unchanged. [game.rb](../lib/games/stratego/game.rb) only composes them.
  - L1: none.
  - L2: the class rule is in
    [guidelines.md](../.github/skills/code-quality/references/guidelines.md).
    `ruby check_board.rb` and `ruby check_army.rb` lock the classes.
  - L3: none.
  - L4: no prompt edit.
  - Links: D10 is the split. A13 is still the next product slice.
    affects: D10, A13, P8.
- **P9** [L0] 2026-11-07. Empty home rows in the private files. Status: done.
  affects: A13, A17, LM14.
- **LM14** 2026-11-07. Source: this iteration.
  - L0: [View](../lib/games/stratego/view.rb) writes inventory plus that
    player's empty home rows. Shared CLI text is unchanged.
  - L1: none.
  - L2: `ruby check_board.rb` locks the two different files. The shared
    board must not appear in either file.
  - L3: none.
  - L4: Q8 is asked. The prompt was not edited.
  - Links: A13 is carried out. Placement stays blocked on Q8.
    affects: A13, A17, A18, Q8.
- **P10** [L0] 2026-11-07. Read the private files. Status: done.
  `./stratego.rb read` accepts only empty home rows. affects: D11, A19, LM15.
- **LM15** 2026-11-07. Source: this iteration.
  - L0: [View#read_all](../lib/games/stratego/view.rb) and
    [start](../lib/games/stratego/game.rb) accept `read`. No piece letters.
  - L1: none.
  - L2: `ruby check_board.rb` locks a successful read and a rejected token
    that is not echoed.
  - L3: none.
  - L4: Q9 is asked. The prompt was not edited.
  - Links: D11 is the placement mechanism. Real placement stays blocked on
    Q9. affects: D11, A19, A20, Q9.
- **P11** [L0] 2026-11-07. Accept D12 tokens in a private file. Status: done.
  affects: D12, A21, LM16.
- **LM16** 2026-11-07. Source: this iteration.
  - L0: [Army::TOKENS](../lib/games/stratego/army.rb).
    [View#error_in](../lib/games/stratego/view.rb) balances placed tokens
    against unplaced counts. Shared CLI text is unchanged.
  - L1: none.
  - L2: `ruby check_army.rb` locks the letters. `ruby check_board.rb` locks
    one placed scout and an extra scout. The token is not printed.
  - L3: none.
  - L4: no prompt edit. Movement is not started.
  - Links: D12 is the token table. A21 is the count layout.
    affects: D12, A21.
