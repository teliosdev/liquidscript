require "liquidscript/icr/representable"

module Liquidscript
  class Scanner
    class Token

      attr_accessor :type
      attr_accessor :value

      include Enumerable
      include ICR::Representable

      def initialize(type, value)
        @type = type
        @value = begin
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

    end

  end
end
