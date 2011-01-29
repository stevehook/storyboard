require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |t|
  t.name = 'specdoc'
  t.rspec_opts = ["--color", "--format", "documentation"]
end