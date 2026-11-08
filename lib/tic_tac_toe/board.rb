module TicTacToe
  class Board
    WINNING_LINES = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6]
    ].freeze

    def initialize(cells: Array.new(9))
      unless cells.is_a?(Array) && cells.length == 9 && cells.all? { |cell| cell.nil? || %w[X O].include?(cell) }
        raise(ArgumentError, 'Board must contain nine empty, X, or O cells')
      end

      @cells = cells.map { |cell| cell&.dup }
    end

    def to_a
      @cells.map { |cell| cell&.dup }
    end

    def initialize_copy(original)
      super
      @cells = @cells.dup
    end

    def after_move(position, mark)
      copy = dup
      raise(ArgumentError, "Invalid move: #{position.inspect}") unless copy.place(position, mark)

      copy
    end

    def place(position, mark)
      return false unless position.is_a?(Integer) && (1..9).cover?(position)
      return false unless %w[X O].include?(mark) && @cells[position - 1].nil?

      @cells[position - 1] = mark
      true
    end

    def winner
      WINNING_LINES.each do |line|
        mark = @cells[line.first]
        return mark if mark && line.all? { |index| @cells[index] == mark }
      end
      nil
    end

    def full?
      @cells.none?(&:nil?)
    end

    def available_positions
      @cells.each_index.filter_map { |index| index + 1 if @cells[index].nil? }
    end
  end
end
