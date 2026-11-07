# frozen_string_literal: true

require_relative "army"

module Games
  module Stratego
    # One player's private file. Both files match until placement exists.
    class View
      FILENAMES = %w[player1.view player2.view].freeze

      def initialize(player, army: Army.new)
        @player = player
        @army = army
      end

      def render
        @army.render
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
