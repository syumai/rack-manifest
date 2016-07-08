# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/manifest/version'

Gem::Specification.new do |spec|
  spec.name          = "rack-manifest"
  spec.version       = Rack::Manifest::VERSION
  spec.authors       = ["syumai"]
  spec.email         = ["syumai@gmail.com"]

  spec.summary       = "Rack middleware for managing HTML5 manifest file by yaml and make it easy to implement in Rails."
  spec.homepage      = "https://github.com/syumai/rack-manifest"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rack"

  spec.add_development_dependency "bundler", "~> 1.12.5"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
