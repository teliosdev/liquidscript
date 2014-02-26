module Liquidscript
  class Scanner
    class Token

      attr_accessor :type
      attr_accessor :value

      extend Forwardable
      include Enumerable
      include Comparable

      def_delegators :to_a, :to_s, :inspect, :each, :'<=>'

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

      alias_method :to_ary, :to_a

    end
  end
end
