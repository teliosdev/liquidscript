RSpec::Matchers.define :generate do |v|
  include Liquidscript

  match do |data|
    (@_out = for_match(generator(data).generate)) ==
    (@_expected = for_match(v))
  end

  description do |data|
    "generate #{v}"
  end

  failure_message do |data|
    sprintf "expected: %{dest}\n     got: %{actual}\n    tree: %{tree}",
      :source => data.inspect,
      :dest   => for_match(v).inspect,
      :actual => actual.inspect,
      :tree   => tree(data)
  end

  diffable

  def actual
    @_out
  end

  def expected
    @_expected
  end

  def generator(data)
    compiler = Compiler::Parser.new(s = Scanner::Liquidscript.new(data))
    compiler.compile
    Generator::Javascript.new(compiler.top)
  rescue Liquidscript::UnexpectedError
    raise
  end

  def tree(data)
    raise
    compiler = Compiler::Parser.new(Scanner::Liquidscript.new(data))
    compiler.compile
    compiler.top.to_sexp
  end

  def for_match(str)
    str.to_s.gsub(/[\s\n\t]+/, '')
  end
end
