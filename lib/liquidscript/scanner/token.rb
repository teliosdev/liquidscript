require "liquidscript/icr/representable"

module Liquidscript
  class Scanner
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
        @value  = begin
          value.pack("c*")
        rescue NoMethodError, TypeError
          value
        end
      end

      def to_a
        [@type, @value]
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
