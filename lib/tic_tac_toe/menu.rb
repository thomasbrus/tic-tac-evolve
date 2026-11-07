require "tty-prompt"

module TicTacToe
  class Menu
    class Cancelled < StandardError; end

    def initialize(input: $stdin, output: $stdout)
      @input = input
      @prompt = TTY::Prompt.new(input: input, output: output)
      @prompt.on(:keyctrl_d) { raise Cancelled }
    end

    def select(question, choices)
      raise ArgumentError, "Menu selection requires an interactive terminal" unless @input.tty?

      @prompt.select(question, choices)
    rescue Cancelled, TTY::Reader::InputInterrupt
      :quit
    end
  end
end
