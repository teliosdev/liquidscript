RSpec::Matchers.define :compile do

  chain :and_produce do |prod|
    @prod = prod
  end

  match do |data|
    begin
      if @prod
        (@_out = compiler(data).compile) == @prod
      else
        @_out = compiler(data).compile
        true
      end

    rescue CompileError => e
      @_error = e
      false
    end
  end

  failure_message_for_should do |data|
    if @prod && !@_error
      "expected #{data} to produce #{@prod} (got: #{@_out})"
    else
      "expected #{data} to compile (got: #{@_error.message})"
    end
  end

  failure_message_for_should_not do |data|
    "expected #{data} not to compile (compiled anyway, got: #{@_out})"
  end

  description do |data|
    "compile #{data}"
  end

  diffable

  def expected
    @prod
  end

  def actual
    @_out.to_a!
  end

  def compiler(data)
    Liquidscript::Compiler::ICR.new(Liquidscript::Scanner.new(data))
  end
end
