# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'imagga/version'

Gem::Specification.new do |gem|
  gem.name          = "imagga"
  gem.version       = Imagga::VERSION
  gem.authors       = ["Mart Karu"]
  gem.email         = ["karu@metal.ee"]
  gem.description   = %q{Ruby client for accessing Imagga API}
  gem.summary       = %q{Ruby client for accessing Imagga API}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "httparty", "~> 0.10"
  gem.add_dependency "json", "~> 1.7"

  gem.add_development_dependency "rspec", "~> 2.12"
  gem.add_development_dependency "rake"
end
