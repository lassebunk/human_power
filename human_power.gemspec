# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'human_power/version'

Gem::Specification.new do |spec|
  s.name          = "human_power"
  s.version       = HumanPower::VERSION
  s.authors       = ["Lasse Bunk"]
  s.email         = ["lassebunk@gmail.com"]
  s.description   = %q{Easy generation of robots.txt.}
  s.summary       = %q{Easy generation of robots.txt. Force the robots into submission!}
  s.homepage      = "https://github.com/lassebunk/human_power"
  s.license       = "MIT"

  s.files         = `git ls-files`.split($/)
  s.test_files    = s.files.grep(%r{^test/})
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler", "~> 1.3"
  s.add_development_dependency "rake"
end
