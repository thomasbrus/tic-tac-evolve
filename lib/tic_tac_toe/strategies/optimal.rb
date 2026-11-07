module TicTacToe
  module Strategies
    class Optimal
      def choose_move(board)
        board.available_positions.max_by do |position|
          score(board.after_move(position, "O"), "X")
        end
      end

      private

      def score(board, mark)
        return 1 if board.winner == "O"
        return -1 if board.winner == "X"
        return 0 if board.full?

        scores = board.available_positions.map do |position|
          score(board.after_move(position, mark), mark == "O" ? "X" : "O")
        end
        mark == "O" ? scores.max : scores.min
      end
    end
  end
end
