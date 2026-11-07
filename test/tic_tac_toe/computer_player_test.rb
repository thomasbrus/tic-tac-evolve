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

    def test_rejects_unknown_strategy
      assert_raises(ArgumentError) { ComputerPlayer.new(strategy: :unknown) }
    end

    def test_easy_and_medium_take_immediate_wins
      [:easy, :medium, :hard].each do |strategy|
        board = board_with(x: [4, 5], o: [1, 2])
        assert_equal 3, ComputerPlayer.new(strategy: strategy).choose_move(board)
      end
    end

    def test_medium_and_hard_block_immediate_losses
      [:medium, :hard].each do |strategy|
        board = board_with(x: [1, 2], o: [5])
        assert_equal 3, ComputerPlayer.new(strategy: strategy).choose_move(board)
      end
    end

    def test_hard_cannot_lose_against_any_sequence_of_human_moves
      player = ComputerPlayer.new(strategy: :hard)
      assert_hard_does_not_lose(Board.new, player, "X")
    end

    private

    def board_with(x:, o:)
      board = Board.new
      x.each { |position| board.place(position, "X") }
      o.each { |position| board.place(position, "O") }
      board
    end

    def assert_hard_does_not_lose(board, player, mark)
      refute_equal "X", board.winner
      return if board.winner || board.full?

      positions = mark == "X" ? board.available_positions : [player.choose_move(board)]
      positions.each do |position|
        assert_includes board.available_positions, position
        assert_hard_does_not_lose(board.after_move(position, mark), player, mark == "X" ? "O" : "X")
      end
    end
  end
end
