require "bundler/gem_tasks"

task :default => :test

require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = Dir["test/**/test_*.rb"]
end