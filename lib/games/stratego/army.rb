# frozen_string_literal: true

module Games
  module Stratego
    # One player's unplaced piece counts. No placement.
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

      def size
        ARMY.sum { |_name, count| count }
      end

      def render
        ARMY.map { |name, count| "#{name} #{count}" }.join("\n")
      end
    end
  end
end
