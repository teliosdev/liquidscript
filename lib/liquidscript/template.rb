require 'liquidscript/icr/sexp'

module Liquidscript
  class Template

    def initialize(data)
      @data = data
    end

    def render
      @_render ||= begin
        compiler = Compiler::ICR.new(Scanner::Liquidscript.new(@data))
        compiler.compile
        puts ICR::Sexp.new(compiler.top).output
        Generator::Javascript.new(compiler.top).generate
      end
    end
  end
end
