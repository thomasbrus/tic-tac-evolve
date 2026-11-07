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
  Not a Decision; rules fidelity is still open. Check: expert overrules the
  squares, or a later agreed ruleset names different ones. Locked by
  [check_board.rb](../check_board.rb). affects: D2, P1, P2.

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
  Status: open, not yet asked. Blocks pieces, moves, and opponents. Does
  not block the board check. affects: A5, D2.

## Pending

- **P1** [L0] 2026-11-07. First board slice. Status: done in
  [stratego.rb](../stratego.rb). affects: D2, A4, A5, LM2.
- **P2** [L2] 2026-11-07. Commit a check for the empty board. Status: done
  in [check_board.rb](../check_board.rb). Run with `ruby check_board.rb`.
  affects: A5, LM3.

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
