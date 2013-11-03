# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby_life/version'

Gem::Specification.new do |spec|
  spec.name          = "ruby_life"
  spec.version       = RubyLife::VERSION
  spec.authors       = ["Eno Compton 4"]
  spec.email         = ["eno4@ecom.com"]
  spec.description   = %q{A command line version of Conway's Game of Life}
  spec.summary       = %q{Observe cells as they live and die on the command line.}
  spec.homepage      = "http://github.com/enocom/ruby_life"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
