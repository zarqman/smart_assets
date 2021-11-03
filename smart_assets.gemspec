require_relative "lib/smart_assets/version"

Gem::Specification.new do |spec|
  spec.name          = "smart_assets"
  spec.version       = SmartAssets::VERSION
  spec.authors       = ["thomas morgan"]
  spec.email         = ["tm@iprog.com"]
  spec.summary       = %q{Rails/Rack middleware to enable delivery of non-digest assets}
  spec.description   = %q{Rails/Rack middleware to enable delivery of non-digest assets with appropriate cache headers.}
  spec.homepage      = "https://github.com/zarqman/smart_assets"
  spec.license       = "MIT"

  spec.metadata["changelog_uri"] = "https://github.com/zarqman/smart_assets/blob/master/CHANGELOG.md"

  spec.files = Dir["lib/**/*", "LICENSE.txt", "Rakefile", "README.md"]

  spec.add_dependency 'rails', '>= 4.0', '< 7.1'
  spec.add_dependency 'sprockets-rails', '>= 2', '< 4'

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "minitest-reporters"
  spec.add_development_dependency "rake"
end
