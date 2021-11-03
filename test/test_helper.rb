# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require 'minitest/reporters'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative "../test/dummy/config/environment"
require "rails/test_help"

require "rails/test_unit/reporter"
Rails::TestUnitReporter.executable = "bin/test"

