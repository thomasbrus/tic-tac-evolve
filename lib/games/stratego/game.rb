# frozen_string_literal: true

require_relative "board"
require_relative "army"
require_relative "view"

# CLI composition root. Board, army, and view rules live in those classes.
module Games
  module Stratego
    ARMY = Army::ARMY
    VIEW_FILENAMES = View::FILENAMES

    module_function

    def army_size
      Army.new.size
    end

    def render_board
      Board.new.render
    end

    def render_inventory
      Army.new.render
    end

    def render_cli
      "#{render_board}\n\n#{render_inventory}"
    end

    def write_private_views(directory = Dir.pwd)
      View.write_all(directory)
    end

    def start
      write_private_views
      puts render_cli
    end
  end
end
