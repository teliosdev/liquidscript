RSpec::Matchers.define :generate do |v|
  include Liquidscript

  match do |data|
    (@_out = for_match(generator(data).generate)) ==
    (@_expected = for_match(v))
  end

  description do |data|
    "generate #{v}"
  end

  failure_message_for_should do |data|
    sprintf "expected %{source} to generate %{dest} (got: %{actual}) - %{tree}",
      :source => data.inspect,
      :dest   => for_match(v).inspect,
      :actual => actual.inspect,
      :tree   => tree(data)
  end

  def actual
    @_out
  end

  def expected
    @_expected
  end

  diffable

  def generator(data)
    compiler = Compiler::ICR.new(Scanner.new(data))
    compiler.compile
    Generator::Javascript.new(compiler.top)
  end

  def tree(data)
    compiler = Compiler::ICR.new(Scanner.new(data))
    compiler.compile
    compiler.top.to_sexp
  end

  def for_match(str)
    str.to_s.gsub(/[\s\n\t]+/, '')
  end
end
