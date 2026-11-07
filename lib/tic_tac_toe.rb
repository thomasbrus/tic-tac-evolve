require "terminal-table"

module TicTacToe
  class Board
    WINNING_LINES = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6]
    ].freeze

    def initialize
      @cells = Array.new(9)
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

    def render
      cells = @cells.each_with_index.map { |mark, index| mark || (index + 1).to_s }
      Terminal::Table.new(rows: cells.each_slice(3).to_a, style: { all_separators: true }).to_s
    end
  end

  class Game
    def initialize(input: $stdin, output: $stdout)
      @input = input
      @output = output
      @board = Board.new
    end

    def play
      mark = "X"
      @output.puts "Tic-tac-toe: enter a square number from 1 to 9, or q to quit."

      loop do
        @output.puts @board.render
        @output.print "Player #{mark}, choose a square: "
        @output.flush
        line = @input.gets

        if line.nil? || line.strip.downcase == "q"
          @output.puts "\nGame ended."
          return
        end

        choice = line.strip
        unless choice.match?(/\A[1-9]\z/) && @board.place(choice.to_i, mark)
          @output.puts "Invalid move. Choose an empty square from 1 to 9."
          next
        end

        if @board.winner
          @output.puts @board.render
          @output.puts "Player #{mark} wins!"
          return
        elsif @board.full?
          @output.puts @board.render
          @output.puts "It's a draw!"
          return
        end

        mark = mark == "X" ? "O" : "X"
      end
    end
  end
end
