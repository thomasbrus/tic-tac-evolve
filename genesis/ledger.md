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
  work. affects: D4, A7, Q5.

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
  Status: open, not asked. Blocks play, not the inventory slice. affects:
  D4, A7.

## Pending

- **P1** [L0] 2026-11-07. First board slice. Status: done in
  [stratego.rb](../stratego.rb). affects: D2, A4, A5, LM2.
- **P2** [L2] 2026-11-07. Commit a check for the empty board. Status: done
  in [check_board.rb](../check_board.rb). Run with `ruby check_board.rb`.
  affects: A5, LM3.
- **P3** [L0] 2026-11-07. Piece inventory. Status: done. `ARMY` and
  `army_size` in [stratego.rb](../stratego.rb). Check: `ruby check_army.rb`.
  affects: D4, A7, LM5.

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
- **LM5** 2026-11-07. Source: this iteration.
  - L0: [stratego.rb](../stratego.rb). Board render unchanged. `ARMY` holds
    the D4 counts. The CLI does not print them.
  - L1: none.
  - L2: `ruby check_board.rb` and `ruby check_army.rb`.
  - L3: none.
  - L4: ledger D4. Q5 still blocks hidden play.
  - Links: the army check fails if the counts drift from D4. affects: D4,
    A7, Q5.
