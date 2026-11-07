require_relative "board"
require_relative "computer_player"
require_relative "menu"

module TicTacToe
  class Game
    def initialize(input: $stdin, output: $stdout, menu: nil, computer_factory: nil)
      @input = input
      @output = output
      @board = Board.new
      @menu = menu || Menu.new(input: input, output: output)
      @computer_factory = computer_factory || ->(strategy) { ComputerPlayer.new(strategy: strategy) }
    end

    def play
      @output.puts "Tic-tac-toe: enter a square number from 1 to 9, or q to quit."
      mode = choose_mode
      return end_game if mode == :quit

      if mode == :computer
        strategy = choose_strategy
        return end_game if strategy == :quit

        @computer = @computer_factory.call(strategy)
      end

      play_round(mode)
    rescue Interrupt
      end_game
    end

    private

    def choose_mode
      @menu.select("Choose a mode:", {
        "Play against the computer" => :computer,
        "Control both X and O" => :both,
        "Quit" => :quit
      })
    end

    def choose_strategy
      @menu.select("Choose a computer strategy:", {
        "Random" => :random,
        "Easy" => :easy,
        "Medium" => :medium,
        "Hard" => :hard,
        "Quit" => :quit
      })
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
