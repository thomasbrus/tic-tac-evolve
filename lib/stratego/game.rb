# frozen_string_literal: true

require_relative 'board'
require_relative 'army'

# CLI composition root. Board and army rules live in those classes.
module Stratego
  module_function

  def start(argv = [], input: $stdin, output: $stdout)
    unless argv.empty?
      warn 'usage: ./stratego.rb'
      exit 1
    end

    setup(Board.new, input:, output:)
  end

  def setup(board, input: $stdin, output: $stdout)
    output.puts 'The board stays open. player2 pieces are shown in lowercase.'
    place_until_done(board, input, output)
    output.puts board.render
    output.puts 'setup complete'
  end

  def place_until_done(board, input, output)
    until board.setup_complete?
      error = read_placement(board, input, output)
      warn error if error
    end
  end

  def read_placement(board, input, output)
    player = board.setup_player
    prompt(board, player, output)
    line = input.gets
    return incomplete(output) if line.nil?

    place_line(board, player, line)
  end

  def prompt(board, player, output)
    output.puts board.render
    output.puts
    output.puts "#{player} places"
    output.puts Army.new.render_unplaced(board.placed_counts(player))
    output.print '> '
    output.flush
  end

  def incomplete(output)
    output.puts
    warn 'setup incomplete'
    exit 1
  end

  def place_line(board, player, line)
    square, token, extra = line.strip.split
    return "usage: a1 #{Army::TOKENS.fetch('flag')}" if square.nil? || token.nil? || extra

    column = square[0]
    row_text = square[1..]
    return "usage: a1 #{Army::TOKENS.fetch('flag')}" unless column && row_text&.match?(/\A(?:10|[1-9])\z/)

    board.place(player, column, row_text.to_i, token)
  end
end
