# Tic-tac-toe

An interactive, two-player tic-tac-toe game for the terminal. The board is rendered with the `terminal-table` Ruby gem.

## Run

Install Ruby and Bundler, then from this directory run:

```sh
bundle install
bundle exec ruby bin/tic-tac-toe
```

Players take turns on the same terminal, starting with X. Enter the number displayed in an empty square to place your mark. Enter `q`, or press Ctrl-D, to end the game early.

## Test

```sh
bundle exec ruby -Itest test/tic_tac_toe_test.rb
```
