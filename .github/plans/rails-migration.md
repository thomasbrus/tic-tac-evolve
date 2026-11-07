# Migrate tic-tac-evolve to Rails

## Outcome and scope
- Outcome: a usable Rails application with server-rendered Haml views, Tailwind CSS 4, Hotwire, and SQLite-backed matches that survive refreshes and server restarts.
- Preserve: the existing CLI, classic 3x3 rules, X starting, local two-player mode, and Random, Easy, Medium, and Hard computer strategies.
- Excluded: accounts, remote multiplayer, new game rules, training AI, production hosting, and migration of nonexistent legacy saved games. Browser tests, visual/keyboard checks, and browser-based server-restart/resume verification are deferred by the user.
- Constraints: share domain logic instead of duplicating rules; validate moves on the server; apply a human move and computer response atomically; preserve user changes; use existing checks and maintained tests rather than inline custom verification scripts.
- Frontend constraint: use Haml for application views and Tailwind CSS 4 for styling; replace ERB application HTML views and handwritten match CSS with the requested stack.
- Dependency policy: select a supported stable Rails release compatible with installed Ruby 4.0.1 and record the resolved version. Keep the Rails app at the repository root alongside the CLI.

## Approval
- Status: approved
- Approved scope and phase sequence: user approved phases 1-3 on 2026-11-07, then requested Haml and Tailwind CSS 4 and explicitly deferred browser testing.
- Execution policy: resumed by the user on 2026-11-07; finish the approved non-browser scope with Haml and Tailwind CSS 4. Do not run browser tests.

## Phases
### 1. Persisted local play in Rails
- Status: complete
- Depends on: none
- Deliverables: Rails foundation, SQLite migration, a shared board-state boundary, and create/show/move endpoints with a usable local two-player board.
- Acceptance criteria: Rails boots; a local game starts empty with X to move; valid moves persist; refresh preserves state; occupied, out-of-range, malformed, and post-completion moves do not change the match; wins and draws are displayed; existing CLI behavior and tests remain intact.
- Verification commands or agreed manual checks: run existing board, computer-player, game, and CLI test files separately with Bundler; run focused Rails model and request/controller tests; run `bin/rails db:prepare` and `bin/rails zeitwerk:check`.
- Results: baseline passed (30 runs, 6,310 assertions). `bin/rails db:prepare` and `bin/rails zeitwerk:check` passed. Phase-one Rails and all CLI tests passed (39 runs, 6,380 assertions, no failures, errors, or skips). Code-quality review found no blocking issues; browser checks were subsequently deferred by the user.

### 2. Computer modes and safe turn handling
- Status: complete
- Depends on: phase 1
- Deliverables: mode and strategy selection, reuse of all four computer strategies, and atomic turn handling with stale-request protection.
- Acceptance criteria: X remains human and O computer; each strategy is selectable; computer responses are legal; a human winning move does not trigger a response; invalid settings are rejected; duplicate or stale submissions cannot produce extra turns; failed responses cannot leave a partially persisted turn.
- Verification commands or agreed manual checks: focused Rails model and request/controller tests, including deterministic strategy scenarios, stale submissions, and transaction rollback; existing computer-player and CLI tests.
- Results: phase-two model, request, strategy, and CLI checks passed (28 runs, 6,319 assertions, no failures, errors, or skips). Invalid AI replies leave storage unchanged, all four modes respond, and stale/missing revisions are rejected. Code-quality review found no blocking issues.

### 3. Match history and end-to-end delivery
- Status: complete
- Depends on: phase 2
- Deliverables: previous-match list and resume links, Haml application views, a Tailwind CSS 4 build, responsive interface markup, and updated run/test documentation. Browser end-to-end coverage is deferred.
- Acceptance criteria for the revised scope: application HTML views use Haml; Tailwind CSS 4 builds the interface utilities; request tests distinguish completed/active matches and restore persisted state; the full maintained non-browser suite passes; the original CLI still works; the local server starts. Desktop/mobile appearance, keyboard operation, and browser-based restart/resume are explicitly unverified until later browser testing.
- Verification commands or agreed manual checks: run `bin/rails test test`, `bin/rails tailwindcss:build`, `bin/rails zeitwerk:check`, editor diagnostics, and whitespace checks; start a local server on an available port and report its URL. No browser automation.
- Results: Haml rendering tests passed (8 runs, 58 assertions). Tailwind CSS 4.3.4 builds successfully and emitted board-grid, mark-color, background, and selected-mode utilities. Unused Capybara/Selenium dependencies removed. `bin/rails test test` passed (50 runs, 6,449 assertions, no failures, errors, or skips). Rails loading, editor diagnostics, and tracked whitespace checks passed. Conversion code-quality review found no blocking issues. `bin/dev` runs Rails and Tailwind at http://localhost:3000; the Haml home page returns HTTP 200. Completion covers the revised non-browser scope only.

## Migration and recovery
- Source: terminal-only application with in-memory rounds and no saved-game database.
- Target: Rails at the repository root, retaining the CLI and shared Ruby game rules, with a new versioned SQLite schema for browser matches.
- Compatibility: no existing saved data requires transformation; CLI entry point and interaction must remain supported. Keep domain objects independent of HTTP and Active Record.
- Data safety: database setup is additive; do not drop or reset databases. Validate persisted match state and submitted moves; do not trust browser-provided marks or outcomes.
- Deployment order: install compatible dependencies, prepare the new database, verify boot and tests, then start the local server. No production deployment is included.
- Recovery: preserve any new database before application rollback. Reverse schema changes only with explicit approval and a backup; dropping match storage would lose created games.

## Decisions and blockers
- Ruby 4.0.1 and Bundler 4.0.3 are installed.
- Existing changes to project learnings and the multi-phase skill are unrelated to Rails implementation and must be preserved.
- The board currently combines rules with terminal rendering; introduce only the state access needed for Rails reuse and retain CLI rendering compatibility.
- Rails 8.1.4.1 is installed and bundled with Ruby 4.0.1.
- User originally selected browser scenarios, but subsequently deferred all browser testing. Keep those scenarios for future work: local wins/draws/refresh; computer modes and completed controls; history and restart/resume; desktop/mobile layout and keyboard access.
- Haml 7.5.2, haml-rails 3.x, tailwindcss-rails 4.7.0, and Tailwind CSS 4.3.4 are installed. Application HTML templates are Haml and match styling uses Tailwind utilities and theme tokens.

## Resume point
- Next action: no remaining implementation work in the revised scope. Browser scenarios and browser-based restart/resume verification can be tackled later when requested.

## Final verification
- Cross-phase checks and outcomes: all 50 maintained tests passed; Tailwind 4 build and utility discovery passed; `bin/rails zeitwerk:check`, editor diagnostics, tracked whitespace checks, and local HTTP response passed. The original CLI system tests passed within the full suite.
- Overall status: approved revised non-browser scope complete. Browser appearance, keyboard interaction, and browser-based server-restart/resume verification were not run and remain deferred at the user's request.
