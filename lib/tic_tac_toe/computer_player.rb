require_relative('strategies/random')
require_relative('strategies/tactical')
require_relative('strategies/optimal')

module TicTacToe
  class ComputerPlayer
    def initialize(strategy: :random, random: Random.new)
      @strategy = case strategy
                  when :random then Strategies::Random.new(random: random)
                  when :easy then Strategies::Tactical.new(random: random, block: false)
                  when :medium then Strategies::Tactical.new(random: random, block: true)
                  when :hard then Strategies::Optimal.new
                  else raise(ArgumentError, "Unknown strategy: #{strategy.inspect}")
                  end
    end

    def choose_move(board)
      raise(ArgumentError, 'No available moves') if board.full?

      @strategy.choose_move(board)
    end
  end
end
