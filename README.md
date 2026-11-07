# Tic-tac-toe

An interactive tic-tac-toe game for the terminal. The board is rendered with `terminal-table`, and menus use `tty-prompt`.

## Run

Install Ruby and Bundler, then from this directory run:

```sh
bundle install
bundle exec ruby bin/tic-tac-toe
```

Use the up and down arrow keys and Enter to choose whether to control both X and O yourself, or play X against the computer as O. In the first mode, you can pass the terminal to another person between turns. X always starts.

Against the computer, use the same menu controls to choose a strategy:

- **Random:** chooses any empty square at random.
- **Easy:** takes an immediate win if available; otherwise plays randomly.
- **Medium:** takes an immediate win or blocks an immediate loss; otherwise plays randomly.
- **Hard:** plays optimally using minimax.

Enter the number displayed in an empty square to place your mark. Enter `q` or press Ctrl-D at a move prompt to end the game early. At a menu, choose Quit or press Ctrl-D or Ctrl-C. Menus require an interactive terminal.

## Test

```sh
bundle exec ruby -Itest -e 'Dir["test/**/*_test.rb"].sort.each { |file| require_relative file }'
```

The suite includes system tests that launch the CLI in a pseudo-terminal and exercise the arrow-key menus and game input. Run them separately with:

```sh
bundle exec ruby test/system/cli_test.rb
```
