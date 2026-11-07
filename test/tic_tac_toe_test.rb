require "minitest/autorun"
require "stringio"
require_relative "../lib/tic_tac_toe"

class TicTacToeTest < Minitest::Test
  def test_all_winning_lines
    TicTacToe::Board::WINNING_LINES.each do |line|
      board = TicTacToe::Board.new
      line.each { |index| assert board.place(index + 1, "X") }
      assert_equal "X", board.winner
    end
  end

  def test_rejects_invalid_and_occupied_positions
    board = TicTacToe::Board.new
    refute board.place(0, "X")
    refute board.place(10, "X")
    refute board.place("1", "X")
    refute board.place(1, "invalid")
    assert board.place(1, "X")
    refute board.place(1, "O")
    assert_includes board.render, "X"
    assert_includes board.render, "2"
  end

  def test_interactive_game_reports_winner
    output = play_game("1\n4\n2\n5\n3\n")
    assert_includes output, "Player X wins!"
    refute_includes output, "It's a draw!"
  end

  def test_interactive_game_reports_draw
    output = play_game("1\n2\n3\n5\n4\n6\n8\n7\n9\n")
    assert_includes output, "It's a draw!"
    refute_includes output, "wins!"
  end

  def test_invalid_moves_do_not_change_turn
    output = play_game("no\n1\n1\n2\nq\n")
    assert_equal 2, output.scan("Invalid move.").length
    assert_equal 3, output.scan("Player X, choose a square:").length
    assert_equal 2, output.scan("Player O, choose a square:").length
    assert_includes output, "Game ended."
  end

  def test_end_of_input_ends_game
    assert_includes play_game(""), "Game ended."
  end

  private

  def play_game(moves)
    output = StringIO.new
    TicTacToe::Game.new(input: StringIO.new(moves), output: output).play
    output.string
  end
end
