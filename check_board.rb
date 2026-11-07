# frozen_string_literal: true

# Locks ledger A5. A rules change has to change this fixture too.
require "open3"
require "rbconfig"
require "tmpdir"
require_relative "lib/games"

S = Games::Stratego

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
fail!("render_board drifted from A5") unless S.render_board == EXPECTED
fail!("render_inventory drifted") unless S.render_inventory == INVENTORY
fail!("render_cli drifted") unless S.render_cli == "#{EXPECTED}\n\n#{INVENTORY}"

script = File.expand_path("stratego.rb", __dir__)
fail!("not executable") unless File.executable?(script)

def run_in_clean_dir(*command)
  Dir.mktmpdir do |dir|
    stdout, status = Open3.capture2(*command, chdir: dir)
    views = S::VIEW_FILENAMES.to_h do |filename|
      path = File.join(dir, filename)
      [filename, File.file?(path) ? File.read(path) : nil]
    end
    [stdout, status, views, Dir.children(dir)]
  end
end

expected_view = "#{INVENTORY}\n"
stdout, status, views, written = run_in_clean_dir(RbConfig.ruby, script)
fail!("ruby exit #{status.exitstatus}") unless status.success?
fail!("ruby output drifted") unless stdout == "#{EXPECTED}\n\n#{INVENTORY}\n"
fail!("ruby view files #{written.inspect}") unless written.sort == S::VIEW_FILENAMES.sort
views.each do |filename, body|
  fail!("#{filename} missing") if body.nil?
  fail!("#{filename} is not only the army") unless body == expected_view
  fail!("#{filename} leaks the board") if body.include?("#") || body.include?("a b c")
end

direct, direct_status, direct_views, = run_in_clean_dir(script)
fail!("direct exit #{direct_status.exitstatus}") unless direct_status.success?
fail!("direct output drifted") unless direct == stdout
fail!("direct views drifted") unless direct_views == views

puts "ok"
