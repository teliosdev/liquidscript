guard :rspec do
  watch(%r{^spec/.+_spec\.rb})
  watch(%r{^lib/(.+)\.rb})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end

guard :rake, :task => "liquidscript:ragel" do
  watch("lib/liquidscript/scanner/lexer.rl")
end
