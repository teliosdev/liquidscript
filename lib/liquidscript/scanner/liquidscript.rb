require "liquidscript/scanner/liquidscript/main"
require "liquidscript/scanner/liquidscript/regexs"
require "liquidscript/scanner/liquidscript/heredocs"
require "liquidscript/scanner/liquidscript/interpolations"

module Liquidscript
  module Scanner
    class Liquidscript < Base

      include Base::DSL

      attr_reader :tokens

      define do
        default_context :main

        context Main
        context Regexs
        context Heredocs
        context Interpolations
      end

      def initialize(*)
        @line = 1
        @cstart = 0
        @lexes = []
        super
      end

      def line!
        @line += 1
        @cstart = @scanner.pos
        while @lexes.any?
          type, @start = @lexes.shift

          lex type
        end
      end

      def normalize_identifier(ident)
        ident.gsub(/\-[a-z]/) { |p| p[1].upcase }
      end

      def line
        @line
      end

      def column
        @scanner.pos - @cstart
      end
    end
  end
end
