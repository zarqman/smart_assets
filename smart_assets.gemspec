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
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'rails', '>= 4.0', '< 5.1'
  spec.add_dependency 'sprockets-rails', '~> 2.0'

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
