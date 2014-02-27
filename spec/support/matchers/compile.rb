RSpec::Matchers.define :compile do

  chain :and_produce do |prod|
    @prod = prod
  end

  match do |data|
    compiler(data).compile?
  end

  failure_message_for_should do |data|
    begin
      compiler(data).compile
    rescue StandardError => e
      "expected #{data} to compile (got: #{e.message})"
    end

    "no."
  end

  failure_message_for_should_not do |data|
    "expected #{data} not to compile (compiled anyway)"
  end

  description do |data|
    "compile #{data}"
  end

  def compiler(data)
    Liquidscript::Compiler.new(Liquidscript::Scanner.new(data))
  end
end
