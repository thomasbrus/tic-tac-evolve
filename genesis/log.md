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
