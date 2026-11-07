require "minitest/autorun"
require_relative "../support/terminal_session"

class CliTest < Minitest::Test
  DOWN = "\e[B"
  ENTER = "\r"

  def test_control_both_sides_with_numbered_moves
    with_terminal do |terminal|
      terminal.wait_for("Choose a mode:")
      terminal.send_keys(ENTER)
      terminal.wait_for("Player X, choose a square:")
      terminal.send_keys("1\n")
      terminal.wait_for("Player O, choose a square:")
      terminal.send_keys("4\n")
      terminal.wait_for("Player X, choose a square:")
      terminal.send_keys("q\n")
      terminal.wait_for("Game ended.")
      assert_predicate terminal.wait_for_exit, :success?
    end
  end

  def test_each_computer_strategy_can_be_selected_with_arrows
    %w[Random Easy Medium Hard].each_with_index do |strategy, index|
      with_terminal do |terminal|
        terminal.wait_for("Choose a mode:")
        terminal.send_keys(DOWN + ENTER)
        terminal.wait_for("Choose a computer strategy:")
        terminal.send_keys(DOWN * index + ENTER)
        output = terminal.wait_for("Player X, choose a square:")
        assert_includes output.gsub(/\e\[[0-9;?]*[a-zA-Z]/, ""), "Choose a computer strategy: #{strategy}"
        terminal.send_keys("1\n")
        terminal.wait_for("Computer (O) chose square")
        terminal.wait_for("Player X, choose a square:")
        terminal.send_keys("q\n")
        terminal.wait_for("Game ended.")
        assert terminal.wait_for_exit.success?, "#{strategy} game failed"
      end
    end
  end

  def test_ctrl_d_exits_mode_menu
    with_terminal do |terminal|
      terminal.wait_for("Choose a mode:")
      terminal.send_keys("\u0004")
      terminal.wait_for("Game ended.")
      assert_predicate terminal.wait_for_exit, :success?
    end
  end

  def test_ctrl_d_exits_strategy_menu
    with_terminal do |terminal|
      terminal.wait_for("Choose a mode:")
      terminal.send_keys(DOWN + ENTER)
      terminal.wait_for("Choose a computer strategy:")
      terminal.send_keys("\u0004")
      terminal.wait_for("Game ended.")
      assert_predicate terminal.wait_for_exit, :success?
    end
  end

  def test_ctrl_c_exits_menu
    with_terminal do |terminal|
      terminal.wait_for("Choose a mode:")
      terminal.send_keys("\u0003")
      terminal.wait_for("Game ended.")
      assert_predicate terminal.wait_for_exit, :success?
    end
  end

  private

  def with_terminal
    terminal = TerminalSession.new
    yield terminal
  ensure
    terminal&.close
  end
end
