# frozen_string_literal: true

# Empty board, piece counts, and private view files. No placement or combat.
module Games
  module Stratego
    COLUMNS = ("a".."j").to_a.freeze
    ROWS = (1..10).to_a.freeze
    LAKES = [
      ["c", 5], ["d", 5], ["c", 6], ["d", 6],
      ["g", 5], ["h", 5], ["g", 6], ["h", 6]
    ].freeze
    ARMY = [
      ["flag", 1],
      ["spy", 1],
      ["scout", 8],
      ["miner", 5],
      ["sergeant", 4],
      ["lieutenant", 4],
      ["captain", 4],
      ["major", 3],
      ["colonel", 2],
      ["general", 1],
      ["marshal", 1],
      ["bomb", 6]
    ].freeze
    VIEW_FILENAMES = %w[player1.view player2.view].freeze

    module_function

    def square(column, row)
      LAKES.include?([column, row]) ? "#" : "."
    end

    def army_size
      ARMY.sum { |_name, count| count }
    end

    def render_board
      header = "   #{COLUMNS.join(" ")}"
      rows = ROWS.map do |row|
        cells = COLUMNS.map { |column| square(column, row) }
        format("%2d %s", row, cells.join(" "))
      end
      [header, *rows].join("\n")
    end

    def render_inventory
      ARMY.map { |name, count| "#{name} #{count}" }.join("\n")
    end

    def render_cli
      "#{render_board}\n\n#{render_inventory}"
    end

    # Unplaced armies match, so the files match until placement exists.
    def private_view(_player)
      render_inventory
    end

    def write_private_views(directory = Dir.pwd)
      VIEW_FILENAMES.each do |filename|
        player = File.basename(filename, ".view")
        File.write(File.join(directory, filename), "#{private_view(player)}\n")
      end
    end

    def start
      write_private_views
      puts render_cli
    end
  end
end
