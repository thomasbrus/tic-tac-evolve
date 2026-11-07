# frozen_string_literal: true

# Locks ledger A5. A rules change has to change this fixture too.
require "open3"
require "rbconfig"
require_relative "stratego"

EXPECTED = [
  "   a b c d e f g h i j",
  " 1 . . . . . . . . . .",
  " 2 . . . . . . . . . .",
  " 3 . . . . . . . . . .",
  " 4 . . . . . . . . . .",
  " 5 . . # # . . # # . .",
  " 6 . . # # . . # # . .",
  " 7 . . . . . . . . . .",
  " 8 . . . . . . . . . .",
  " 9 . . . . . . . . . .",
  "10 . . . . . . . . . ."
].join("\n").freeze

INVENTORY = [
  "flag 1",
  "spy 1",
  "scout 8",
  "miner 5",
  "sergeant 4",
  "lieutenant 4",
  "captain 4",
  "major 3",
  "colonel 2",
  "general 1",
  "marshal 1",
  "bomb 6"
].join("\n").freeze

def fail!(message)
  warn "check_board: #{message}"
  exit 1
end

lines = EXPECTED.lines(chomp: true)
inventory_lines = INVENTORY.lines(chomp: true)
fail!("expected 11 lines") unless lines.size == 11
fail!("header") unless lines[0] == "   a b c d e f g h i j"

lakes = []
lines[1..].each_with_index do |line, index|
  row = index + 1
  label, rest = line.split(" ", 2)
  fail!("row label #{label.inspect}") unless label == row.to_s
  squares = rest.split
  fail!("row #{row} width") unless squares.size == 10
  squares.each_with_index do |cell, column_index|
    fail!("bad cell #{cell.inspect}") unless cell == "#" || cell == "."
    lakes << "#{(column_index + 97).chr}#{row}" if cell == "#"
  end
end
fail!("lakes #{lakes.join(" ")}") unless lakes == %w[c5 d5 g5 h5 c6 d6 g6 h6]
counts = inventory_lines.map do |line|
  name, count = line.split
  fail!("inventory line #{line.inspect}") unless name && count&.match?(/\A\d+\z/)
  [name, count.to_i]
end
fail!("inventory size") unless counts.sum { |_name, count| count } == 40
fail!("render_board drifted from A5") unless render_board == EXPECTED
fail!("render_inventory drifted") unless render_inventory == INVENTORY
fail!("render_cli drifted") unless render_cli == "#{EXPECTED}\n\n#{INVENTORY}"

script = File.expand_path("stratego.rb", __dir__)
fail!("not executable") unless File.executable?(script)

stdout, status = Open3.capture2(RbConfig.ruby, script)
fail!("ruby exit #{status.exitstatus}") unless status.success?
fail!("ruby output drifted") unless stdout == "#{EXPECTED}\n\n#{INVENTORY}\n"

direct, direct_status = Open3.capture2(script)
fail!("direct exit #{direct_status.exitstatus}") unless direct_status.success?
fail!("direct output drifted") unless direct == stdout

puts "ok"
