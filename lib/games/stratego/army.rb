# frozen_string_literal: true

module Games
  module Stratego
    # Piece counts and the D12 setup tokens.
    class Army
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
      TOKENS = {
        "flag" => "F",
        "spy" => "S",
        "scout" => "9",
        "miner" => "8",
        "sergeant" => "7",
        "lieutenant" => "6",
        "captain" => "5",
        "major" => "4",
        "colonel" => "3",
        "general" => "2",
        "marshal" => "1",
        "bomb" => "B"
      }.freeze

      def size
        ARMY.sum { |_name, count| count }
      end

      def render
        ARMY.map { |name, count| "#{name} #{count}" }.join("\n")
      end
    end
  end
end
