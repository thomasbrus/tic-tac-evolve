# frozen_string_literal: true

require_relative 'army'

module Stratego
  # The shared open board: lakes and placed pieces.
  class Board
    COLUMNS = ('a'..'j').to_a.freeze
    ROWS = (1..10).to_a.freeze
    LAKES = [
      ['c', 5], ['d', 5], ['c', 6], ['d', 6],
      ['g', 5], ['h', 5], ['g', 6], ['h', 6]
    ].freeze
    HOME_ROWS = {
      'player1' => (1..4).to_a,
      'player2' => (7..10).to_a
    }.freeze

    def initialize
      @pieces = {}
    end

    def square(column, row)
      return '#' if LAKES.include?([column, row])

      piece = @pieces[[column, row]]
      return '.' unless piece

      player, token = piece
      player == 'player2' ? token.downcase : token
    end

    def render_row(row)
      cells = COLUMNS.map { |column| square(column, row) }
      format('%<row>2d %<cells>s', row: row, cells: cells.join(' '))
    end

    def render_rows(rows)
      rows.map { |row| render_row(row) }.join("\n")
    end

    def render
      header = "   #{COLUMNS.join(' ')}"
      [header, render_rows(ROWS)].join("\n")
    end

    def setup_player
      HOME_ROWS.keys.find { |player| !army_placed?(player) }
    end

    def setup_complete?
      setup_player.nil?
    end

    def placed_counts(player)
      counts = Hash.new(0)
      @pieces.each_value do |owner, token|
        next unless owner == player

        counts[Army::TOKENS.key(token)] += 1
      end
      counts
    end

    # Returns an error string, or nil when the piece is on the board.
    def place(player, column, row, token)
      column = column.to_s.downcase
      error = square_error(player, column, row)
      return error if error

      known = canonical_token(token)
      error = piece_error(player, known)
      return error if error

      @pieces[[column, row]] = [player, known]
      nil
    end

    private

    def square_error(player, column, row)
      return 'not your turn' unless player == setup_player
      return 'off the board' unless COLUMNS.include?(column)
      return 'not your row' unless HOME_ROWS.fetch(player).include?(row)

      'occupied' if @pieces.key?([column, row])
    end

    def piece_error(player, known)
      return 'unknown piece' unless known

      name = Army::TOKENS.key(known)
      limit = Army::ARMY.to_h.fetch(name)
      'none left' if placed_counts(player).fetch(name, 0) >= limit
    end

    def canonical_token(token)
      Army::TOKENS.each_value.find { |value| value.casecmp?(token.to_s) }
    end

    def army_placed?(player)
      counts = placed_counts(player)
      Army::ARMY.all? { |name, count| counts.fetch(name, 0) == count }
    end
  end
end
