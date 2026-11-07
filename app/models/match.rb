class Match < ApplicationRecord
  STRATEGIES = { "random" => "Random", "easy" => "Easy", "medium" => "Medium", "hard" => "Hard" }.freeze

  validates :mode, inclusion: { in: %w[local computer] }
  validates :strategy, inclusion: { in: STRATEGIES.keys }, if: -> { mode == "computer" }
  validates :strategy, absence: true, if: -> { mode == "local" }
  validate :valid_board_state

  def board
    TicTacToe::Board.new(cells: cells)
  end

  def current_mark
    cells.count("X") == cells.count("O") ? "X" : "O"
  end

  def complete?
    board.winner.present? || board.full?
  end

  def status_label
    return "#{board.winner} wins" if board.winner
    return "Draw" if board.full?

    "#{current_mark} to move"
  end

  def mode_label
    mode == "computer" ? "Computer / #{STRATEGIES.fetch(strategy)}" : "Two players"
  end

  def play(position:, expected_version: lock_version)
    with_lock do
      next reject_move("The board changed. Choose a move on the current board.") unless expected_version == lock_version
      next reject_move("This match is already complete.") if complete?

      next_board = board
      next reject_move("Choose an empty square from 1 to 9.") unless next_board.place(position, current_mark)

      play_computer_turn(next_board) if mode == "computer" && !next_board.winner && !next_board.full?
      update!(cells: next_board.to_a)
    end
  rescue ActiveRecord::StaleObjectError
    reload
    reject_move("The board changed. Choose a move on the current board.")
  end

  private

  def play_computer_turn(snapshot)
    position = TicTacToe::ComputerPlayer.new(strategy: strategy.to_sym).choose_move(snapshot)
    raise ArgumentError, "Computer chose an invalid move" unless snapshot.place(position, "O")
  end

  def reject_move(message)
    errors.add(:base, message)
    false
  end

  def valid_board_state
    snapshot = board
    x_count = cells.count("X")
    o_count = cells.count("O")
    valid_counts = x_count == o_count || x_count == o_count + 1
    winner = snapshot.winner
    valid_winner = winner.nil? || (winner == "X" ? x_count == o_count + 1 : x_count == o_count)
    valid_finish = winner.nil? || cells.each_index.any? do |index|
      next false unless cells[index] == winner

      predecessor = snapshot.to_a
      predecessor[index] = nil
      TicTacToe::Board.new(cells: predecessor).winner.nil?
    end
    valid_turn = mode != "computer" || winner || snapshot.full? || x_count == o_count
    errors.add(:cells, "must describe a reachable game") unless valid_counts && valid_winner && valid_finish && valid_turn
  rescue ArgumentError
    errors.add(:cells, "must contain nine empty, X, or O cells")
  end
end
