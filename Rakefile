require "bundler/setup"

require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  `pushd test/dummy ; rails assets:clobber assets:precompile`
  t.libs << "test"
  t.pattern = "test/**/*_test.rb"
  t.verbose = false
end

task default: :test
