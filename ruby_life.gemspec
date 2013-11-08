# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby_life/version'

Gem::Specification.new do |gem|
  gem.name          = "ruby_life"
  gem.version       = RubyLife::VERSION
  gem.authors       = ["Eno Compton 4"]
  gem.email         = ["eno4@ecom.com"]
  gem.description   = %q{A command line version of Conway's Game of Life}
  gem.summary       = %q{Observe cells as they live and die on the CLI.}
  gem.homepage      = "http://github.com/enocom/ruby_life"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "bundler", "~> 1.3"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
end
