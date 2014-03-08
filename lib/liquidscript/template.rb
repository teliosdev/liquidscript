module Liquidscript
  class Template

    def initialize(data)
      @data = data
    end

    def render
      @_render ||= begin
        compiler = Compiler::ICR.new(Scanner.new(@data))
        compiler.compile
        Generator::Javascript.new(compiler.top).generate
      end
    end
  end
end
