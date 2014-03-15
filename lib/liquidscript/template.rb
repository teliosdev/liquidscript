require 'liquidscript/icr/sexp'

module Liquidscript
  class Template

    def initialize(data)
      @data = data
    end

    def render
      @_render ||= begin
        compiler = Compiler::ICR.new(s = Scanner::Liquidscript.new(@data))
        compiler.compile
        Generator::Javascript.new(compiler.top).generate
      end
    end
  end
end
