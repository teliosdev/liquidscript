require "bundler/gem_tasks"
require "rspec/core/rake_task"


RSpec::Core::RakeTask.new('spec')

namespace :ls do
  desc "Opens up a pry session."
  task :pry do
    require "pry"
    require File.expand_path("../lib/liquidscript", __FILE__)
    Pry.start
  end
end
