require "liquidscript/buffer"
require "liquidscript/compiler/expressions"
require "liquidscript/compiler/literals"

module Liquidscript

  class Compiler

    extend Forwardable
    def_delegators :@scanner, :peek

    include Expressions
    include Literals

    attr_reader :set

    def initialize(scanner)
      @scanner = scanner.each
      @top = ICR::Set.new
      @top.metadata[:context] = ICR::Context.new
      @set = [@top]
    end

    def pop
      @scanner.next
    end

    def top
      @set.last
    end

    def compile
      while peek
        top.push compile_expression
      end
    rescue StopIteration
      top
    end

    def compile?
      compile
      true
    rescue CompileError
      false
    ensure
      @top = ICR::Set.new
      @top.metadata[:context] = ICR::Context.new
      @set = [@top]
    end

    def shift_if(*types)
      if peek?(*types)
        pop
      else
        raise CompileError.new(types, peek.type)
      end
    end

    def peek?(*types)
      types.any? { |type| peek.type? type }
    end

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

      if block.respond_to?(:call)
        if block.respond_to?(:arity) && block.arity == 1
          block.call pop
        else
          block.call
        end
      end

      # discard it...

    rescue KeyError
      raise UnexpectedError.new(hash.keys, peek.type)
    end

  end
end
