require "liquidscript/icr/representable"

module Liquidscript
  module Scanner
    class Token

      attr_accessor :type
      attr_accessor :value
      attr_reader :line
      attr_reader :column

      include Enumerable
      include ICR::Representable

      def initialize(type, value, line, column)
        @type   = type
        @line   = line
        @column = column
        @value  = value
      end

      def to_a
        [@type, @value, @line, @column]
      end

      def type?(type)
        @type == type
      end

      def empty?
        false
      end

    end

  end
end
