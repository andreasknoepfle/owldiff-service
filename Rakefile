require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << ['test','lib']
  t.pattern = "test/test_*.rb"
end
task :default => :test
