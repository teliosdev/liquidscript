module Liquidscript
  module ICR

    # Used to show that a specific element of the ICR is representable
    # as an array.  It will forward the methods #to_s and #inspect to
    # the #to_a method, expecting the including module to define it.
    module Representable

      extend Forwardable
      include Comparable

      def_delegators :to_a, :to_s, :inspect, :[], :each, :'<=>', :length


      def to_ary
        to_a
      end

      def to_yaml
        to_a!.to_yaml
      end

      def to_sexp
        Sexp.new(self)
      end

      def to_a!
        do_map = proc do |e|
          if e.is_a?(Representable)
            e.to_a!
          elsif e.is_a? Array
            e.map(&do_map)
          else
            e
          end
        end

        to_a.map(&do_map)
      end

    end
  end
end
