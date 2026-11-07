# frozen_string_literal: true

# Empty Stratego board. Lakes are an assumption (ledger A5), not an agreed ruleset.
COLUMNS = ("a".."j").to_a.freeze
ROWS = (1..10).to_a.freeze
LAKES = [
  ["c", 5], ["d", 5], ["c", 6], ["d", 6],
  ["g", 5], ["h", 5], ["g", 6], ["h", 6]
].freeze

def square(column, row)
  LAKES.include?([column, row]) ? "#" : "."
end

def render_board
  header = "   #{COLUMNS.join(" ")}"
  rows = ROWS.map do |row|
    cells = COLUMNS.map { |column| square(column, row) }
    format("%2d %s", row, cells.join(" "))
  end
  [header, *rows].join("\n")
end

puts render_board if $PROGRAM_NAME == __FILE__
