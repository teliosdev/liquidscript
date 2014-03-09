require 'liquidscript/icr/sexp'

module Liquidscript
  class Template

    def initialize(data)
      @data = data
    end

    def render
      @_render ||= begin
        p Scanner.new(@data).each
        compiler = Compiler::ICR.new(Scanner.new(@data))
        compiler.compile
        puts ICR::Sexp.new(compiler.top).output
        Generator::Javascript.new(compiler.top).generate
      end
    end
  end
end
