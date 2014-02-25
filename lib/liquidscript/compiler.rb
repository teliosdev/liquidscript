require "liquidscript/buffer"
require "liquidscript/compiler/expressions"

module Liquidscript

  class CompileError < StandardError; end
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
    
    protected
    
    def expect(*args)
      hash = if args.last.is_a? Hash
        args.pop
      else 
        {}
      end

      args.each do |arg|
        hash[arg] = arg
      end

      block = hash.fetch(peek.type) do
        hash.fetch(:_)
      end
      
      if block.is_a? Symbol
        block = method(:"compile_#{block}")
      end
    
      if block.arity == 1
        block.call pop
      else
        block.call
      end
      
    rescue KeyError
      raise CompileError, "Expected one of " +
        "#{hash.keys.map(&:to_s).map(&:upcase).join(', ')}, " +
        "got #{peek.type.to_s.upcase}"
    end

  end
end
