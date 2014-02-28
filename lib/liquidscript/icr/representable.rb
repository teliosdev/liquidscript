module Liquidscript
  module ICR

    # Used to show that a specific element of the ICR is representable
    # as an array.  It will forward the methods #to_s and #inspect to
    # the #to_a method, expecting the including module to define it.
    module Representable

      extend Forwardable
      include Comparable

      def_delegators :to_a, :to_s, :inspect, :[], :each, :'<=>'


      def to_ary
        to_a
      end

    end
  end
end
