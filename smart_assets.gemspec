# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'smart_assets/version'

Gem::Specification.new do |spec|
  spec.name          = "smart_assets"
  spec.version       = SmartAssets::VERSION
  spec.authors       = ["thomas morgan"]
  spec.email         = ["tm@iprog.com"]
  spec.summary       = %q{Rails/Rack middleware to enable delivery of non-digest assets}
  spec.description   = %q{Rails/Rack middleware to enable delivery of non-digest assets.}
  spec.homepage      = "https://github.com/zarqman/smart_assets"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = ["lib"]

  spec.add_dependency 'rails', '>= 4.0', '< 6'
  spec.add_dependency 'sprockets-rails', '>= 2', '< 4'

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "minitest-reporters"
  spec.add_development_dependency "rake"
end
