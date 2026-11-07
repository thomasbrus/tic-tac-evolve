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

fail!("names") unless Games::Stratego::ARMY.map(&:first) == EXPECTED.keys.to_a
fail!("counts") unless Games::Stratego::ARMY.to_h == EXPECTED
fail!("army_size") unless Games::Stratego.army_size == 40
fail!("fixture") unless EXPECTED.values.sum == 40

puts "ok"
