require "bundler/gem_tasks"
require "rspec/core/rake_task"


RSpec::Core::RakeTask.new('spec')

namespace :ls do
  rule '.rb' => ['.rl'] do |t|
    sh "ragel -R #{t.source}"
  end

  desc "Builds the ragel parser."
  task :ragel => ["lib/liquidscript/scanner/lexer.rb"]

  desc "Opens up a pry session."
  task :pry => [:ragel] do
    require "pry"
    require File.expand_path("../lib/liquidscript", __FILE__)
    Pry.start
  end

  task :clean do
    File.unlink("lib/liquidscript/scanner/lexer.rb")
  end
end
