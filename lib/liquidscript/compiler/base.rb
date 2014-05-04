require "liquidscript/compiler/base/blank"
require "liquidscript/compiler/base/action"
require "liquidscript/compiler/base/helpers"
require "liquidscript/compiler/base/callable"

module Liquidscript
  module Compiler
    class Base

      include Helpers
      extend Forwardable

      # Initializes the compiler.
      #
      # @param scanner [Scanner, #each] the scanner.  Used to
      #   manage the  tokens.  This could be stubbed out, if
      #   the #each function returns an Enumerator, which yields
      #   {Scanner::Token}s.
      def initialize(scanner)
        @scanner  = scanner
        @iterator = scanner.each
        @action   = Action.new
        reset!
      end

      # Returns the top set.  If the variable @top isn't set by the
      # inheriting class, then it defaults to the value of an array.
      #
      # @return [Array, #push]
      def top
        @top ||= []
      end

      # Begins the compiliation.  Continues until the iterator raises
      # a `StopIteration` error, and then returns the top set with
      # {#top}.
      #
      # @raise [CompileError] if there's an error compiling.
      # @raise [UnexpectedEndError] if the top {Array} isn't the topmost
      #   set.
      # @return [Array] the topmost set.
      def compile
        # We're using this cool property of Base::Blank such that it
        # will return a nil to any method call.
        while !peek.is_a?(Blank) do
          top.push compile_start
        end

        top

      rescue InvalidReferenceError => e
        p top.context
        raise
      rescue CompileError => e
        token = peek
        part = "#{File.expand_path(@scanner.metadata[:file])}" +
          ":#{token.line}:#{token.column}: " +
          "before #{token.type.to_s.upcase}"
        raise e, e.message, [part, *e.backtrace]
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

      def scanner_nil
        @_blank ||= Blank.new
      end

      # Pops the next argument off of the scanner.  If the call
      # raises a {StopIteration} error, it returns the value of
      # {#scanner_nil} instead.
      #
      # @return [#type?, Blank]
      def pop
        @iterator.next
      rescue StopIteration
        scanner_nil
      end

      # Peeks at the next argument on the scanner.  If the call
      # raises a {StopIteration} error, it returns the value of
      # {#scanner_nil} instead.
      #
      # @return [#type, Blank]
      def peek
        @iterator.peek
      rescue StopIteration
        scanner_nil
      end

      # Resets the state of the compiler.
      #
      # @return [void]
      def reset!
        @iterator.rewind
      end

      alias_method :rewind, :reset!

    end
  end
end
