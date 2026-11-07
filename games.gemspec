# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "games"
  spec.version = "0.1.0"
  spec.summary = "Games, including a Stratego CLI."
  spec.authors = ["Thomas Brus"]
  spec.license = nil
  spec.files = Dir["lib/**/*.rb", "stratego.rb"]
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 3.2"
end
