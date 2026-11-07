require "minitest/autorun"
require "stringio"
require_relative "../../lib/tic_tac_toe/game"

module TicTacToe
  class GameTest < Minitest::Test
    def test_interactive_game_reports_winner
      output = play_game("1\n4\n2\n5\n3\n")
      assert_includes output, "Player X wins!"
      assert_match(/\| X \| X \| X \|.*Player X wins!/m, output)
      refute_includes output, "It's a draw!"
    end

    def test_interactive_game_reports_o_winner
      output = play_game("1\n4\n2\n5\n7\n6\n")
      assert_includes output, "Player O wins!"
      assert_match(/\| O \| O \| O \|.*Player O wins!/m, output)
    end

    def test_interactive_game_reports_draw
      output = play_game("1\n2\n3\n5\n4\n6\n8\n7\n9\n")
      assert_includes output, "It's a draw!"
      assert_match(/\| O \| X \| X \|.*It's a draw!/m, output)
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

    def test_quit_is_case_insensitive_and_accepts_whitespace
      output = play_game("  Q  \n")
      assert_includes output, "Game ended."
      refute_includes output, "Invalid move."
    end

    def test_mode_selection_retries_invalid_input
      output = play_game("no\n1\nq\n", select_mode: false)
      assert_includes output, "Invalid mode. Enter 1 or 2."
      assert_includes output, "Player X, choose a square:"
    end

    def test_can_quit_or_end_input_at_mode_selection
      ["q\n", "", "  Q  \n"].each do |input|
        output = play_game(input, select_mode: false)
        assert_includes output, "Game ended."
        refute_includes output, "choose a square"
      end
    end

    def test_computer_plays_o_and_reports_its_move
      output = play_game("2\n1\nq\n", select_mode: false, computer: ComputerPlayer.new(random: Random.new(1)))
      assert_includes output, "Computer (O) chose square"
      refute_includes output, "Player O, choose a square:"
      assert_equal 2, output.scan("Player X, choose a square:").length
      assert_includes output, "Game ended."
    end

    def test_invalid_move_does_not_trigger_computer_turn
      computer = Minitest::Mock.new
      computer.expect(:choose_move, 2, [Board])
      output = play_game("2\nno\n1\n2\nq\n", select_mode: false, computer: computer)
      assert_equal 2, output.scan("Invalid move.").length
      assert_equal 1, output.scan("Computer (O) chose square").length
      computer.verify
    end

    def test_invalid_computer_move_raises_an_error
      computer = Minitest::Mock.new
      computer.expect(:choose_move, 1, [Board])
      error = assert_raises(RuntimeError) { play_game("2\n1\n", select_mode: false, computer: computer) }
      assert_includes error.message, "Computer chose an invalid move"
      computer.verify
    end

    def test_computer_can_win
      computer = Minitest::Mock.new
      [4, 5, 6].each { |position| computer.expect(:choose_move, position, [Board]) }
      output = play_game("2\n1\n2\n7\n", select_mode: false, computer: computer)
      assert_includes output, "Computer (O) wins!"
      assert_match(/\| O \| O \| O \|.*Computer \(O\) wins!/m, output)
      computer.verify
    end

    def test_player_can_win_against_computer
      computer = Minitest::Mock.new
      [4, 5].each { |position| computer.expect(:choose_move, position, [Board]) }
      output = play_game("2\n1\n2\n3\n", select_mode: false, computer: computer)
      assert_includes output, "Player X wins!"
      computer.verify
    end

    def test_computer_game_can_end_in_a_draw
      computer = Minitest::Mock.new
      [2, 5, 6, 7].each { |position| computer.expect(:choose_move, position, [Board]) }
      output = play_game("2\n1\n3\n4\n8\n9\n", select_mode: false, computer: computer)
      assert_includes output, "It's a draw!"
      computer.verify
    end

    private

    def play_game(moves, select_mode: true, computer: ComputerPlayer.new)
      output = StringIO.new
      input = select_mode ? "1\n#{moves}" : moves
      Game.new(input: StringIO.new(input), output: output, computer: computer).play
      output.string
    end
  end
end
