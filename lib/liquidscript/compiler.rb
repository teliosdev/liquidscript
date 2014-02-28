require "liquidscript/buffer"
require "liquidscript/compiler/expressions"
require "liquidscript/compiler/literals"
require "liquidscript/compiler/helpers"
require "liquidscript/compiler/action"

module Liquidscript

  class Compiler

    include Expressions
    include Literals
    include Helpers

    attr_reader :set

    # Initializes the compiler.
    #
    # @param scanner [Scanner, #each] the scanner.  Used to
    #   manage the  tokens.  This could be stubbed out, if
    #   the #each function returns an Enumerator, which yields
    #   {Scanner::Token}s.
    def initialize(scanner)
      @scanner = scanner.each
      @action  = Action.new
      reset!
    end

    # The top {Set}.  This is used with variables to handle
    # references.  New functions introduce new {ICR::Set}s, along with
    # a new context.  The top context is the most inner {Set} scope.
    #
    # @return [Set]
    def top
      @set.last
    end

    # Begins the compiliation.  Continues until the iterator raises
    # a `StopIteration` error, and then returns the top set with
    # {#top}.
    #
    # @raises [CompileError] if there's an error compiling.
    # @raises [UnexpectedEndError] if the top {Set} isn't the topmost
    #   set.
    # @return [Set] the topmost set.
    def compile
      while peek.value do
        top.push compile_expression
      end

      top
    end

    # Checks to see if the given input compiles.
    #
    # @see [#compile]
    # @return [Boolean] if it compiles.
    def compile?
      compile
      true
    rescue CompileError
      false
    ensure
      reset!
    end

    # Resets the state of the compiler.  This will bring the scanner
    # back to the beginning, and the {Set} and {Context} will be
    # reset.
    #
    # @return [void]
    def reset!
      @top         = ICR::Set.new
      @top.context = ICR::Context.new
      @set         = [@top]
      @scanner.rewind
    end

  end
end
