require "liquidscript/buffer"
require "liquidscript/compiler/expressions"

module Liquidscript
  class Compiler

    extend Forwardable
    include Expressions
    def_delegators :@scanner, :peek

    attr_reader :buffer

    def initialize(scanner)
      @scanner = scanner.each
      @buffer = Buffer.new
    end

    def pop
      @scanner.next
    end

    def compile
      while peek
        compile_expression
      end
    rescue StopIteration
      @buffer
    end

  end
end
