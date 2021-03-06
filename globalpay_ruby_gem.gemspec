# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'globalpay_ruby_gem/version'

Gem::Specification.new do |spec|
  spec.name          = "globalpay_ruby_gem"
  spec.version       = GlobalpayRubyGem::VERSION
  spec.authors       = ["Codegidi"]
  spec.email         = ["me@codegidi.com"]

  spec.summary       = ["Zenith bank Globalpay payment gateway integration."]
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 1.12"
  spec.add_development_dependency "rake", ">= 10.0"

  spec.required_ruby_version = '>= 2.0.0'
  spec.add_runtime_dependency 'httpclient'
end
