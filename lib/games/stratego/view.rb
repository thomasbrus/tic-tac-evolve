# frozen_string_literal: true

require_relative "army"
require_relative "board"

module Games
  module Stratego
    # One player's private file. Home rows differ; counts match until placement.
    class View
      FILENAMES = %w[player1.view player2.view].freeze
      HOME_ROWS = {
        "player1" => (1..4).to_a,
        "player2" => (7..10).to_a
      }.freeze

      def initialize(player, army: Army.new, board: Board.new)
        @player = player
        @army = army
        @board = board
      end

      def render
        rows = HOME_ROWS.fetch(@player)
        "#{@army.render}\n\n#{@board.render_rows(rows)}"
      end

      def write(directory)
        File.write(File.join(directory, "#{@player}.view"), "#{render}\n")
      end

      def self.write_all(directory = Dir.pwd, army: Army.new)
        FILENAMES.each do |filename|
          player = File.basename(filename, ".view")
          new(player, army: army).write(directory)
        end
      end

      # Returns error strings. Cell tokens are not echoed.
      def self.read_all(directory = Dir.pwd)
        FILENAMES.filter_map do |filename|
          player = File.basename(filename, ".view")
          path = File.join(directory, filename)
          next "#{filename} missing" unless File.file?(path)

          error = new(player).error_in(File.read(path))
          "#{filename} #{error}" if error
        end
      end

      def error_in(body)
        inventory, rows = body.sub(/\n\z/, "").split("\n\n", 2)
        return "is not inventory plus home rows" unless rows

        unplaced = inventory_counts(inventory)
        return unplaced if unplaced.is_a?(String)

        placed = row_counts(rows)
        return placed if placed.is_a?(String)

        Army::ARMY.each do |name, count|
          got = unplaced.fetch(name, 0) + placed.fetch(name, 0)
          return "#{name} count" unless got == count
        end
        nil
      end

      def inventory_counts(inventory)
        lines = inventory.lines(chomp: true)
        names = Army::ARMY.map(&:first)
        return "inventory lines" unless lines.size == names.size

        lines.zip(names).to_h do |line, name|
          piece, count = line.split(" ", 2)
          return "inventory name" unless piece == name
          return "inventory count" unless count&.match?(/\A\d+\z/)

          [name, count.to_i]
        end
      end

      def row_counts(rows)
        lines = rows.lines(chomp: true)
        expected_rows = HOME_ROWS.fetch(@player)
        return "home row count" unless lines.size == expected_rows.size

        counts = Hash.new(0)
        expected_rows.zip(lines) do |row, line|
          label, rest = line.split(" ", 2)
          return "row label" unless label == row.to_s

          cells = rest.to_s.split
          return "row width" unless cells.size == Board::COLUMNS.size
          cells.each do |cell|
            next if cell == "."

            name = Army::TOKENS.key(cell)
            return "has an unknown piece" unless name

            counts[name] += 1
          end
        end
        counts
      end
    end
  end
end
