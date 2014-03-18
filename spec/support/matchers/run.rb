RSpec::Matchers.define :run do
  command = Command::Runner.new("node", "")
  match do |data|
    @output = Liquidscript.compile(data)
    @message = command.run({}, :input => @output)
    @message.successful?
  end

  failure_message_for_should do
    "Expected to run, got:\n#{@message.stderr}"
  end
end
