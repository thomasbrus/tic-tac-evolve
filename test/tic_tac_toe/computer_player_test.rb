require "minitest/autorun"
require_relative "../../lib/tic_tac_toe/board"
require_relative "../../lib/tic_tac_toe/computer_player"

module TicTacToe
  class ComputerPlayerTest < Minitest::Test
    def test_chooses_only_available_positions
      board = Board.new
      (1..8).each { |position| board.place(position, "X") }
      assert_equal 9, ComputerPlayer.new(random: Random.new(1)).choose_move(board)
    end

    def test_rejects_a_full_board
      board = Board.new
      (1..9).each { |position| board.place(position, "X") }
      assert_raises(ArgumentError) { ComputerPlayer.new.choose_move(board) }
    end
  end
end
