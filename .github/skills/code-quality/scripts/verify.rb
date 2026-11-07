#!/usr/bin/env ruby
# frozen_string_literal: true

require "open3"
require "rbconfig"
require "tmpdir"

def fail!(message)
  warn "code-quality: #{message}"
  exit 1
end

def repo_root
  dir = File.expand_path(__dir__)
  6.times do
    return dir if File.file?(File.join(dir, "games.gemspec"))
    parent = File.dirname(dir)
    break if parent == dir
    dir = parent
  end
  fail!("games.gemspec not found from #{__dir__}")
end

def run!(command, chdir:)
  stdout, stderr, status = Open3.capture3(*command, chdir: chdir)
  return stdout if status.success?

  warn stdout
  warn stderr
  fail!("#{command.join(" ")} exited #{status.exitstatus}")
end

root = repo_root
ruby_files = Dir[
  File.join(root, "lib/**/*.rb"),
  File.join(root, "*.rb"),
  File.join(root, ".github/skills/**/*.rb")
]
ruby_files.uniq.each do |path|
  next if path.include?("/.git/")
  run!([RbConfig.ruby, "-c", path], chdir: root)
end

run!([RbConfig.ruby, File.join(root, "check_board.rb")], chdir: root)
run!([RbConfig.ruby, File.join(root, "check_army.rb")], chdir: root)

launcher = File.join(root, "stratego.rb")
fail!("stratego.rb is not executable") unless File.executable?(launcher)
Dir.mktmpdir do |dir|
  run!([launcher], chdir: dir)
  views = Dir.children(dir).grep(/\.view\z/)
  fail!("launcher wrote #{views.inspect}") unless views.sort == %w[player1.view player2.view]
end

gem_out = run!(["gem", "build", File.join(root, "games.gemspec")], chdir: root)
built = gem_out.lines.grep(/File: /).map { |line| line.split("File: ", 2).last.strip }
built.each do |name|
  path = File.join(root, name)
  File.delete(path) if File.file?(path)
end

puts "ok"
