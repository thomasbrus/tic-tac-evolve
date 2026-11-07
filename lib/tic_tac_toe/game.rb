require_relative "board"
require_relative "computer_player"

module TicTacToe
  class Game
    def initialize(input: $stdin, output: $stdout, computer: ComputerPlayer.new)
      @input = input
      @output = output
      @board = Board.new
      @computer = computer
    end

    def play
      @output.puts "Tic-tac-toe: enter a square number from 1 to 9, or q to quit."
      mode = choose_mode
      return end_game unless mode

      play_round(mode)
    end

    private

    def choose_mode
      @output.puts "Choose a mode: 1) Control both X and O  2) Play against the computer"
      loop do
        @output.print "Mode (1 or 2): "
        @output.flush
        choice = @input.gets
        return nil if quit?(choice)

        case choice.strip
        when "1" then return :both
        when "2" then return :computer
        else @output.puts "Invalid mode. Enter 1 or 2."
        end
      end
    end

    def play_round(mode)
      mark = "X"

      loop do
        show_board
        result = take_turn(mark, mode)
        return end_game if result == :quit
        next if result == :invalid
        return announce_result(mark, mode) if game_over?

        mark = mark == "X" ? "O" : "X"
      end
    end

    def take_turn(mark, mode)
      if mode == :computer && mark == "O"
        computer_move
        return :played
      end

      choice = read_choice(mark)
      return :quit if quit?(choice)

      make_move(choice, mark) ? :played : :invalid
    end

    def computer_move
      position = @computer.choose_move(@board)
      raise "Computer chose an invalid move: #{position.inspect}" unless @board.place(position, "O")

      @output.puts "Computer (O) chose square #{position}."
    end

    def show_board
      @output.puts @board.render
    end

    def read_choice(mark)
      @output.print "Player #{mark}, choose a square: "
      @output.flush
      @input.gets
    end

    def quit?(choice)
      choice.nil? || choice.strip.downcase == "q"
    end

    def end_game
      @output.puts "\nGame ended."
    end

    def make_move(choice, mark)
      choice = choice.strip
      return true if choice.match?(/\A[1-9]\z/) && @board.place(choice.to_i, mark)

      @output.puts "Invalid move. Choose an empty square from 1 to 9."
      false
    end

    def game_over?
      @board.winner || @board.full?
    end

    def announce_result(mark, mode)
      show_board
      winner = mode == :computer && mark == "O" ? "Computer (O)" : "Player #{mark}"
      @output.puts(@board.winner ? "#{winner} wins!" : "It's a draw!")
    end
  end
end
