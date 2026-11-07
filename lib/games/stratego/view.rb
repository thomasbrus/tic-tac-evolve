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
    end
  end
end
