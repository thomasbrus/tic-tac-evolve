require_relative "random"

module TicTacToe
  module Strategies
    class Tactical
      def initialize(random:, block:)
        @fallback = Random.new(random: random)
        @block = block
      end

      def choose_move(board)
        winning_move(board, "O") ||
          (@block && winning_move(board, "X")) ||
          @fallback.choose_move(board)
      end

      private

      def winning_move(board, mark)
        board.available_positions.find { |position| board.after_move(position, mark).winner == mark }
      end
    end
  end
end
