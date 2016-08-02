# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nlocal/directory/version'

Gem::Specification.new do |spec|
  spec.name          = "nlocal-directory"
  spec.version       = Nlocal::Directory::VERSION
  spec.authors       = ["Daniel Prado"]
  spec.email         = ["daniel.prado@nlocal.com"]
  spec.summary       = %q{Provides connection to Nlocal-directory API}
  spec.description   = %q{Packs models for all endpoints from Nlocal-directory API. Based on Her gem.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.5"
  spec.add_development_dependency "factory_girl", "~> 4.0"
  spec.add_runtime_dependency "her", "~> 0.8"
  spec.add_runtime_dependency "request_store", "~> 1.3"
end
