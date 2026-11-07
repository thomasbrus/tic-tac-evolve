# tic-tac-evolve

tic-tac-evolve is an experiment in a human-guided, AI-assisted development workflow that improves through feedback. The tic-tac-toe game is its proof of concept: a small application for exercising the workflow as project instructions, reusable skills, and lessons evolve alongside the code.

## Milestones

| Milestone | Description | Source |
| --- | --- | --- |
| CLI | Terminal game with interactive menus and four computer strategies. | [CLI snapshot](https://github.com/thomasbrus/tic-tac-evolve/tree/f2d428aceccb9ff03bf8719b37e2ef40cf8b8b4c) |
| Rails | Persisted browser matches with Haml, Tailwind CSS 4, and Hotwire. | [Rails snapshot](https://github.com/thomasbrus/tic-tac-evolve/tree/dda8d4fba010dec4c885f577b73d5fd8f806eb37) |
| Main | Latest committed development; changes as the project evolves. | [main](https://github.com/thomasbrus/tic-tac-evolve/tree/main) |

The game runs in a Rails application and in the original terminal CLI. Both use the same board rules and computer strategies. The web application uses Haml, Tailwind CSS 4, Hotwire, and SQLite.

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

## Run the CLI

The CLI still renders its board with `terminal-table` and uses `tty-prompt` menus:

```sh
bundle exec ruby bin/tic-tac-toe
```

Use the up and down arrow keys and Enter to choose whether to control both X and O yourself, or play X against the computer as O. In the first mode, you can pass the terminal to another person between turns. X always starts.

Both interfaces offer the same computer strategies:

- **Random:** chooses any empty square at random.
- **Easy:** takes an immediate win if available; otherwise plays randomly.
- **Medium:** takes an immediate win or blocks an immediate loss; otherwise plays randomly.
- **Hard:** plays optimally using minimax.

Enter the number displayed in an empty square to place your mark. Enter `q`, or press Ctrl-D or Ctrl-C at a move prompt to end the game early. At a menu, choose Quit or press Ctrl-D or Ctrl-C. Menus require an interactive terminal.

## Test

Run all maintained model, request, domain, and CLI system tests:

```sh
bin/rails test test
bin/rails tailwindcss:build
bin/rails zeitwerk:check
```

The suite includes system tests that launch the CLI in a pseudo-terminal and exercise the arrow-key menus and game input. Run them separately with:

```sh
bundle exec ruby test/system/cli_test.rb
```

Browser testing, visual checks, and browser-based server-restart/resume verification are deferred. The current suite checks persisted state, rendered forms and history, illegal moves, computer responses, and stale submissions without launching a browser.
