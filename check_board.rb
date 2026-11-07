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
fail!("Board class") unless S::Board.is_a?(Class)
fail!("View class") unless S::View.is_a?(Class)
fail!("render_board drifted from A5") unless S::Board.new.render == EXPECTED
fail!("module render_board drifted") unless S.render_board == EXPECTED
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

def home_rows(range)
  range.map { |row| format("%2d %s", row, Array.new(10, ".").join(" ")) }.join("\n")
end

expected_views = {
  "player1.view" => "#{INVENTORY}\n\n#{home_rows(1..4)}\n",
  "player2.view" => "#{INVENTORY}\n\n#{home_rows(7..10)}\n"
}.freeze
fail!("player1 home rows") unless S::View.new("player1").render == expected_views["player1.view"].chomp
fail!("player2 home rows") unless S::View.new("player2").render == expected_views["player2.view"].chomp

stdout, status, views, written = run_in_clean_dir(RbConfig.ruby, script)
fail!("ruby exit #{status.exitstatus}") unless status.success?
fail!("ruby output drifted") unless stdout == "#{EXPECTED}\n\n#{INVENTORY}\n"
fail!("ruby view files #{written.inspect}") unless written.sort == S::VIEW_FILENAMES.sort
views.each do |filename, body|
  fail!("#{filename} missing") if body.nil?
  fail!("#{filename} drifted") unless body == expected_views.fetch(filename)
  fail!("#{filename} leaks the shared board") if body.include?("#") || body.include?("a b c")
  home = body.lines(chomp: true).grep(/\A\s*\d+ /)
  fail!("#{filename} home row count") unless home.size == 4
  fail!("#{filename} has a placed piece") unless home.all? { |line| line.split[1..].all? { |cell| cell == "." } }
  other = filename == "player1.view" ? (7..10) : (1..4)
  other.each do |row|
    fail!("#{filename} has the other player's row #{row}") if body.include?(format("%2d ", row))
  end
end

direct, direct_status, direct_views, = run_in_clean_dir(script)
fail!("direct exit #{direct_status.exitstatus}") unless direct_status.success?
fail!("direct output drifted") unless direct == stdout
fail!("direct views drifted") unless direct_views == views

Dir.mktmpdir do |dir|
  _setup, setup_status = Open3.capture2(script, chdir: dir)
  fail!("setup before read") unless setup_status.success?
  read_out, read_err, read_status = Open3.capture3(script, "read", chdir: dir)
  fail!("read exit #{read_status.exitstatus}") unless read_status.success?
  fail!("read output") unless read_out == "ok\n"
  fail!("read stderr") unless read_err.empty?

  path = File.join(dir, "player1.view")
  File.write(path, File.read(path).sub(" .", " X"))
  bad_out, bad_err, bad_status = Open3.capture3(script, "read", chdir: dir)
  fail!("placed piece accepted") if bad_status.success?
  leaked = "#{bad_out}#{bad_err}"
  fail!("read leaked the token") if leaked.include?("X")
  fail!("read did not name the file") unless leaked.include?("player1.view")
end

Dir.mktmpdir do |dir|
  _setup, setup_status = Open3.capture2(script, chdir: dir)
  fail!("setup before place") unless setup_status.success?
  path = File.join(dir, "player1.view")
  File.write(path, File.read(path).sub("scout 8", "scout 7").sub(" .", " 9"))
  placed_out, placed_err, placed_status = Open3.capture3(script, "read", chdir: dir)
  fail!("placed scout rejected") unless placed_status.success?
  fail!("placed scout leaked") if "#{placed_out}#{placed_err}".include?("9")

  File.write(path, File.read(path).sub("scout 7", "scout 8"))
  bad_out, bad_err, bad_status = Open3.capture3(script, "read", chdir: dir)
  fail!("extra scout accepted") if bad_status.success?
  fail!("count error leaked the token") if "#{bad_out}#{bad_err}".include?("9")
  fail!("count error") unless bad_err.include?("scout count")
end

puts "ok"
