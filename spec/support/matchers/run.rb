RSpec::Matchers.define :run do
  command = Command::Runner.new("node", "")
  match do |data|
    @output = Liquidscript::Template.new(data).render
    @message = command.run({}, :input => @output)
    @message.successful?
  end

  failure_message_for_should do
    "Expected to run, got:\n#{@message.stderr}"
  end
end
