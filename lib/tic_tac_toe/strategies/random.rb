module TicTacToe
  module Strategies
    class Random
      def initialize(random:)
        @random = random
      end

      def choose_move(board)
        board.available_positions.sample(random: @random)
      end
    end
  end
end
