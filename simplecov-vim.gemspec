# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'simplecov-vim/version'

Gem::Specification.new do |s|
  s.name          = "simplecov-vim"
  s.version       = Simplecov::VERSION
  s.authors       = ["Judson Lester"]
  s.email         = ["nyarly@gmail.com"]
  s.homepage      = "https://github.com/nyarly/simplecov-vim"
  s.summary       = "Vim coverage from Simplecov"
  s.description   = <<-EndDescription
  Defines a formatter that emits a vim script to mark up code with coverage
  data: refactor in deluded confidence!
  EndDescription

  s.files         = `git ls-files app lib`.split("\n")
  s.platform      = Gem::Platform::RUBY
  s.require_paths = ['lib']
  s.rubyforge_project = s.name.downcase
  s.licenses = ["MIT"]

  s.add_development_dependency "bundler", "~> 1.3"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
end
