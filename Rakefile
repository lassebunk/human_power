require "bundler/gem_tasks"
require "rake/testtask"
require "appraisal"

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

if !ENV["APPRAISAL_INITIALIZED"] && !ENV["TRAVIS"]
  task :default do
    sh "appraisal install && rake appraisal test"
  end
else
  task :default => :test
end
