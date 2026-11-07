# frozen_string_literal: true

# Locks the D4 piece counts. Placement and combat are out of scope.
require_relative "lib/games"

EXPECTED = {
  "flag" => 1,
  "spy" => 1,
  "scout" => 8,
  "miner" => 5,
  "sergeant" => 4,
  "lieutenant" => 4,
  "captain" => 4,
  "major" => 3,
  "colonel" => 2,
  "general" => 1,
  "marshal" => 1,
  "bomb" => 6
}.freeze

def fail!(message)
  warn "check_army: #{message}"
  exit 1
end

fail!("Army class") unless Games::Stratego::Army.is_a?(Class)
fail!("tokens") unless Games::Stratego::Army::TOKENS == {
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
}
fail!("names") unless Games::Stratego::Army::ARMY.map(&:first) == EXPECTED.keys.to_a
fail!("counts") unless Games::Stratego::Army::ARMY.to_h == EXPECTED
fail!("module army drifted") unless Games::Stratego::ARMY == Games::Stratego::Army::ARMY
fail!("army_size") unless Games::Stratego::Army.new.size == 40
fail!("module army_size drifted") unless Games::Stratego.army_size == 40
fail!("fixture") unless EXPECTED.values.sum == 40

puts "ok"
