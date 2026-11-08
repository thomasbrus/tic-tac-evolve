require('minitest/autorun')
require_relative('../../lib/tic_tac_toe/board')

module TicTacToe
  class BoardTest < Minitest::Test
    def test_restores_state_without_sharing_mutable_cells
      cells = [String.new('X'), 'O', nil, nil, nil, nil, nil, nil, nil]
      board = Board.new(cells: cells)
      cells.first.replace('O')
      snapshot = board.to_a
      snapshot.first.replace('O')
      snapshot[2] = 'X'

      assert_equal(['X', 'O', nil, nil, nil, nil, nil, nil, nil], board.to_a)
      assert_equal([3, 4, 5, 6, 7, 8, 9], board.available_positions)
    end

    def test_rejects_malformed_state
      [nil, 'XXXXXXXXX', [], Array.new(8), ['Z'] + Array.new(8)].each do |cells|
        assert_raises(ArgumentError) { Board.new(cells: cells) }
      end
    end

    def test_all_winning_lines
      Board::WINNING_LINES.each do |line|
        board = Board.new
        line.each { |index| assert(board.place(index + 1, 'X')) }
        assert_equal('X', board.winner)
      end
    end

    def test_rejects_invalid_and_occupied_positions
      board = Board.new
      refute(board.place(0, 'X'))
      refute(board.place(10, 'X'))
      refute(board.place('1', 'X'))
      refute(board.place(1, 'invalid'))
      assert(board.place(1, 'X'))
      refute(board.place(1, 'O'))
      assert_includes(board.to_a, 'X')
      assert_includes(board.available_positions, 2)
    end

    def test_available_positions_excludes_occupied_squares
      board = Board.new
      assert_equal((1..9).to_a, board.available_positions)
      board.place(2, 'X')
      board.place(9, 'O')
      assert_equal([1, 3, 4, 5, 6, 7, 8], board.available_positions)
    end

    def test_after_move_does_not_change_original_board
      board = Board.new
      copy = board.after_move(1, 'X')
      assert_equal((1..9).to_a, board.available_positions)
      refute_includes(copy.available_positions, 1)
      assert_raises(ArgumentError) { copy.after_move(1, 'O') }
    end
  end
end
