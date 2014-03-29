require 'set'
require 'strscan'
require 'liquidscript/scanner/base/builder'
require 'liquidscript/scanner/base/context'
require 'liquidscript/scanner/base/dsl'
require 'liquidscript/scanner/base/lexer'

module Liquidscript
  module Scanner
    # TODO: documentation
    class Base

      EXIT = Object.new.freeze

      include Lexer
      include Enumerable

      attr_accessor :metadata

      def initialize(source)
        @source   = source
        @scanner  = StringScanner.new(@source)
        @tokens   = []
        @_scan    = nil
        @metadata = {}
      end

      def contexts
        self.class.contexts
      end

      def default_context
        self.class.default
      end

      def scan
        lex default_context
        self
      end

      def each
        e = buffer.each

        if block_given?
          e.each(&Proc.new)
        else
          e
        end
      end

      def line
        "(unknown)"
      end

      def column
        "(unkown)"
      end

      def emit(token_name, body = nil)
        @tokens << Token.new(token_name, body, line, column)
      end

      def inspect
        "#<#{self.class}:#{'0x%08x' % object_id}>"
      end

      private

      def buffer
        @_scan ||= begin
          scan
          @tokens
        end
      end
    end
  end
end
