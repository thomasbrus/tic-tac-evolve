# tic-tac-evolve

tic-tac-evolve is an experiment in a human-guided, AI-assisted development workflow that improves through feedback. The tic-tac-toe game is its proof of concept: a small application for exercising the workflow as project instructions, reusable skills, and lessons evolve alongside the code.

## Milestones

| Milestone | Description | Source |
| --- | --- | --- |
| CLI | Terminal game with interactive menus and four computer strategies. | [CLI snapshot](https://github.com/thomasbrus/tic-tac-evolve/tree/f2d428aceccb9ff03bf8719b37e2ef40cf8b8b4c) |
| Rails | Persisted browser matches with Haml, Tailwind CSS 4, and Hotwire. | [Rails snapshot](https://github.com/thomasbrus/tic-tac-evolve/tree/dda8d4fba010dec4c885f577b73d5fd8f806eb37) |
| Main | Latest committed development; changes as the project evolves. | [main](https://github.com/thomasbrus/tic-tac-evolve/tree/main) |

The game runs as a Rails web application with persisted matches. It uses shared board rules and computer strategies implemented in [lib/tic_tac_toe/](lib/tic_tac_toe/). The web application uses Haml, Tailwind CSS 4, Hotwire, and SQLite.

## How the workflow works

The human sets the direction and remains responsible for accepting the result. The AI assists with implementation, tests, investigation, and review. The game provides a concrete way to test that collaboration as requirements and technology change.

1. **Define the change.** Describe the desired behavior, constraints, and existing behavior that must remain intact. Clarify consequential choices, such as the frontend stack, before implementation.
2. **Implement and verify.** The assistant inspects the relevant code, makes a small change, and runs focused checks. Larger changes use an approved sequence of milestones; ordinary edits do not need a formal plan.
3. **Review and correct.** The human reviews the diff, behavior, and verification results. Feedback should identify the mismatch and intended outcome, not just ask the assistant to try again.
4. **Capture reusable lessons.** The assistant considers whether a correction reveals a durable rule. Current conventions belong in the relevant instructions or skill; the learning history records the scenario, correction, and rationale. Routine fixes and duplicate lessons do not need new entries.
5. **Carry the improvement forward.** Commit useful guidance alongside the project. Future assistance can load the relevant rules instead of rediscovering the same preferences. Tests and CI provide executable checks where prose alone is insufficient.

For example, "Use relative Rails translations for template-specific labels" becomes a view convention, a recorded learning, and rendering tests. The correction improves both the current code and the instructions used for subsequent work.

| Resource | Purpose |
| --- | --- |
| [.github/copilot-instructions.md](.github/copilot-instructions.md) | Project-wide working principles, verification policy, and commit conventions. |
| [.github/instructions/rails.instructions.md](.github/instructions/rails.instructions.md) | Rules for Rails/Ruby code, shared game logic, and migrations. |
| [.github/instructions/views.instructions.md](.github/instructions/views.instructions.md) | Haml, Tailwind CSS 4, Hotwire, and translation conventions. |
| [.github/skills/](.github/skills/) | On-demand procedures for phased delivery, code-quality review, reflection, and commits. |
| [.github/memory/learnings.md](.github/memory/learnings.md) | Historical lessons and why conventions were adopted. |
| [.github/plans/](.github/plans/) | Approved milestones, decisions, verification results, and resume points for substantial work. |

This is not automatic model training, and instructions do not guarantee compliance. Improvement comes from versioned guidance, human review, and repeatable checks. The same development practices apply when working without an AI assistant.

## Run the web application

Use Ruby 4.0.1 and Bundler, then from this directory run:

```sh
bundle install
bin/rails db:prepare
bin/rails tailwindcss:build
bin/dev
```

Open `http://localhost:3000`. `bin/dev` runs Rails and the Tailwind watcher together. To use another port, run `PORT=3001 bin/dev`.

Start a local two-player match or play X against the computer as O. Match history links let you resume active games and view completed ones. Matches are stored in `storage/development.sqlite3`; refreshing the page or stopping the server does not intentionally discard them. There are no accounts: this is a shared local application, not a private or remotely hosted multiplayer service.

## Develop on the project

Start with the web setup above. Keep `bin/dev` running while editing; it runs the Rails server and rebuilds Tailwind when relevant files change.

| Area | Location |
| --- | --- |
| Shared board rules and computer strategies | [lib/tic_tac_toe/](lib/tic_tac_toe/) |
| Persisted matches and turn handling | [app/models/match.rb](app/models/match.rb) |
| Requests and Haml views | [app/controllers/](app/controllers/) and [app/views/](app/views/) |
| Tailwind theme and browser interactions | [app/assets/tailwind/](app/assets/tailwind/) and [app/javascript/](app/javascript/) |
| Translations and schema changes | [config/locales/](config/locales/) and [db/migrate/](db/migrate/) |
| Domain and request tests | [test/](test/) |

Keep changes focused and preserve intentional defaults. Reuse shared rules rather than implementing a second version in controllers or views. Use Haml and Tailwind CSS 4 for the frontend; use `t(".key")` for template-specific text and absolute keys for genuinely shared translations. Add database migrations rather than editing the generated schema or resetting databases to resolve failures.

Add or update a test for the changed behavior, then run the smallest relevant slice. For example:

```sh
bin/rails test test/controllers/matches_controller_test.rb
bundle exec ruby test/tic_tac_toe/board_test.rb
```

Use the broader checks in the Test section for shared behavior, dependencies, or migrations. Review the diff for unrelated edits, missing cases, and unclear responsibilities before committing. Documentation-only changes normally need documentation/whitespace checks, not the application suite.

In VS Code Copilot Chat, the project skills can be invoked explicitly:

- `/multi-phase <goal>` proposes a durable plan and requests approval before implementation. Add `plan-only` to defer implementation; after approval, execution continues through the agreed phases unless paused or blocked.
- `/code-quality` reviews responsibilities, maintainability, and behavioral risks in the changed code.
- `/self-reflection` evaluates a correction for a reusable lesson, updating an existing entry instead of duplicating it.
- `/commit` reviews scope and staging, checks the intended contents, and creates coherent commits. It does not push changes.

State acceptance criteria and constraints in a feature request, and give specific corrections during review. Ask for a commit only when the change is ready; failed checks must be reported rather than hidden. GitHub Actions runs the non-browser test suite, Tailwind build, and Rails loading checks on pushes and pull requests using [.github/workflows/ci.yml](.github/workflows/ci.yml).

## Test

Run all maintained model, request, and domain tests:

```sh
bin/rails test test
bin/rails tailwindcss:build
bin/rails zeitwerk:check
```

The suite checks persisted state, rendered forms and history, illegal moves, computer responses, and stale submissions.

Browser testing, visual checks, and browser-based server-restart/resume verification are deferred.
