# tic-tac-evolve

tic-tac-evolve is an experiment in a human-guided, AI-assisted development workflow that improves through feedback. The tic-tac-toe game is its proof of concept: a small application for exercising the workflow as project instructions, reusable skills, and lessons evolve alongside the code.

## Milestones

| Milestone | Description | Source |
| --- | --- | --- |
| CLI | Terminal game with interactive menus and four computer strategies. | [CLI snapshot](https://github.com/thomasbrus/tic-tac-evolve/tree/f2d428aceccb9ff03bf8719b37e2ef40cf8b8b4c) |
| Rails | Persisted browser matches with Haml, Tailwind CSS 4, and Hotwire. | [Rails snapshot](https://github.com/thomasbrus/tic-tac-evolve/tree/dda8d4fba010dec4c885f577b73d5fd8f806eb37) |
| Main | Latest committed development; changes as the project evolves. | [main](https://github.com/thomasbrus/tic-tac-evolve/tree/main) |

The Rails app persists matches to SQLite and uses Haml, Tailwind CSS 4, and Hotwire for the frontend. Shared board rules and computer strategies live in [lib/tic_tac_toe/](lib/tic_tac_toe/).

## How the workflow works

The human sets direction and is responsible for accepting results. The AI assists with implementation, tests, investigation, and review.

1. **Define the change.** Describe desired behavior, constraints, and what must remain intact. Clarify important choices like the frontend stack before implementation starts.
2. **Implement and verify.** The assistant reads relevant code, makes focused changes, and runs appropriate checks. Larger work uses an approved milestone sequence; routine edits don't need formal plans.
3. **Review and correct.** You review the diff, behavior, and results. Feedback should describe the mismatch and what you want instead, not ask the assistant to try again.
4. **Capture lessons.** The assistant considers whether a correction reveals a reusable rule. Conventions go into relevant instruction files; the learning history records the scenario, correction, and rationale. One-off fixes don't need entries.
5. **Carry it forward.** Useful guidance becomes part of the project. Future work loads the same rules instead of rediscovering them. Tests and CI provide executable checks.

For example: "Use relative Rails translations for template-specific labels" becomes a view convention, a recorded learning, and rendering tests.

| Resource | Purpose |
| --- | --- |
| [.github/copilot-instructions.md](.github/copilot-instructions.md) | Project-wide working principles, verification policy, and commit conventions. |
| [.github/instructions/rails.instructions.md](.github/instructions/rails.instructions.md) | Rules for Rails/Ruby code, shared game logic, and migrations. |
| [.github/instructions/views.instructions.md](.github/instructions/views.instructions.md) | Haml, Tailwind CSS 4, Hotwire, and translation conventions. |
| [.github/skills/](.github/skills/) | On-demand procedures for phased delivery, code-quality review, reflection, and commits. |
| [.github/memory/learnings.md](.github/memory/learnings.md) | Historical lessons and why conventions were adopted. |
| [.github/initiatives/](.github/initiatives/) | Current index and records for persistent multi-session initiatives. |
| [.github/plans/](.github/plans/) | Earlier milestone plans, decisions, and verification records. |

This is not automatic model training, and instructions don't guarantee compliance. Improvement comes from versioned guidance, human review, and repeatable checks.

## Run the web application

Use Ruby 4.0.1 and Bundler, then from this directory run:

```sh
bundle install
bin/rails db:prepare
bin/rails tailwindcss:build
bin/dev
```

Open `http://localhost:3000` and start a local two-player match or play X against the computer as O. Match history links let you resume games in progress and view completed ones.

Matches are stored in `storage/development.sqlite3`. There are no accounts—this is a shared local application.

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

Keep changes focused and preserve intentional defaults. Reuse shared rules instead of implementing duplicates in controllers or views. Use Haml and Tailwind CSS 4 for the frontend; use `t(".key")` for template-specific text and absolute keys for shared translations.

Add or update a test for the changed behavior, then run the smallest relevant slice. For example:

```sh
bin/rails test test/controllers/matches_controller_test.rb
bundle exec ruby test/tic_tac_toe/board_test.rb
```

Before finishing Haml or lint-configuration changes, run `bundle exec haml-lint`. It checks all Haml views/partials and runs RuboCop on their embedded Ruby, not standalone Ruby files. Follow the [view conventions](.github/instructions/views.instructions.md) for strict locals, single quotes, parentheses, and class syntax; review the class fallback order manually.

Use the broader checks in the Test section for shared behavior, dependencies, or migrations. Review the diff for unrelated edits, missing cases, and unclear responsibilities before committing. Documentation-only changes normally need documentation/whitespace checks, not the application suite.

In VS Code Copilot Chat, the project skills can be invoked explicitly:

- `/initiative` for persistent multi-session engineering initiatives; it loads the workflow and repository records from [initiatives](.github/initiatives/README.md).
- `/code-quality` reviews responsibilities, maintainability, and behavioral risks in the changed code.
- `/self-reflection` evaluates a correction for a reusable lesson, updating an existing entry instead of duplicating it.
- `/commit` reviews scope and staging, checks the intended contents, and creates coherent commits. It does not push changes.
- [`/fix-ci`](.github/skills/fix-ci/SKILL.md) accepts a GitHub Actions run URL or failure email, investigates a focused fix, and commits and pushes after validation. It requires an authenticated `gh` CLI, allows at most two repair attempts, and asks when blocked. Add `diagnose-only` to prevent edits or `no-push` to keep the fix local. It does not monitor email automatically.

State acceptance criteria and constraints in feature requests. Give specific corrections during review, not vague feedback. Ask for a commit when the change is ready; flag failed checks instead of hiding them.

## Test

Run all maintained model, request, and domain tests:

```sh
bundle exec haml-lint
bin/rails test test
bin/rails tailwindcss:build
bin/rails zeitwerk:check
```

The suite checks persisted state, rendered forms and history, illegal moves, computer responses, and stale submissions. Browser testing and visual checks are deferred.

[CI](.github/workflows/ci.yml) runs these checks on Ubuntu 24.04 using the Ruby version in [.ruby-version](.ruby-version). It caches the Ruby installation separately from gems, keyed by the OS, architecture, and Ruby version. The installation cache includes Ruby's tool-cache completion marker and is saved before application checks, so a test failure does not prevent reuse. Cache misses still require a Ruby download.
