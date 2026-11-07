module TicTacToe
  class ComputerPlayer
    def initialize(random: Random.new)
      @random = random
    end

    def choose_move(board)
      positions = board.available_positions
      raise ArgumentError, "No available moves" if positions.empty?

      positions.sample(random: @random)
    end
  end
end
