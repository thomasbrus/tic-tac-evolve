# frozen_string_literal: true

module Games
  module Stratego
    # The shared 10x10 board, including the lakes. No pieces.
    class Board
      COLUMNS = ("a".."j").to_a.freeze
      ROWS = (1..10).to_a.freeze
      LAKES = [
        ["c", 5], ["d", 5], ["c", 6], ["d", 6],
        ["g", 5], ["h", 5], ["g", 6], ["h", 6]
      ].freeze

      def square(column, row)
        LAKES.include?([column, row]) ? "#" : "."
      end

      def render
        header = "   #{COLUMNS.join(" ")}"
        rows = ROWS.map do |row|
          cells = COLUMNS.map { |column| square(column, row) }
          format("%2d %s", row, cells.join(" "))
        end
        [header, *rows].join("\n")
      end
    end
  end
end
