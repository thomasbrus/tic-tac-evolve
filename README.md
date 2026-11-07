# Tic-tac-toe

An interactive tic-tac-toe game for the terminal. The board is rendered with the `terminal-table` Ruby gem.

## Run

Install Ruby and Bundler, then from this directory run:

```sh
bundle install
bundle exec ruby bin/tic-tac-toe
```

Choose whether to control both X and O yourself, or play X against the computer as O. In the first mode, you can pass the terminal to another person between turns. X always starts; the computer chooses an available square at random.

Enter the number displayed in an empty square to place your mark. Enter `q`, or press Ctrl-D, to end the game early, including at the mode prompt.

## Test

```sh
bundle exec ruby -Itest -e 'Dir["test/**/*_test.rb"].sort.each { |file| require_relative file }'
```
