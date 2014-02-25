module Liquidscript
  module ICR
  
    # Represents a set of instruction codes.  Can contain
    # metadata about the set, like whether or not it can
    # be inlined, if a new context needs to be applied,
    # etc.
    class Set
    
      # The metadata that is applied to the set.
      #
      # @return [Hash]
      attr_reader :metadata
      
      extend Forwardable
      
      def_delegators :to_a, :to_s, :inspect
      
      # Initialize the set.
      def initialize
        @metadata = {}
        @code = []
      end
      
      # Turns the set into an array.  Includes the
      # metadata information and the actual internal
      # array.
      # Note that this is _not_ the array used in
      # {method_missing} - that actually operates on
      # the internal array.
      #
      # @return [Array]
      def to_a
        [
          @metadata.to_a.map { |(m, i)| [:"_#{m}", i] }, 
          @code
        ].flatten(1)
      end
      
      # Tells ruby that we respond to some methods.
      # Passes the method name to the internal
      # array, asking if it responds to it.
      #
      # @param method [Symbol] the method to check.
      # @param include_private [Boolean] whether or not
      #   to include private methods.
      # @return [Boolean] whether or not we respond
      #   to that method.
      def respond_to_missing?(method, include_private = false)
        @code.respond_to?(method, include_private)
      end
      
      # For methods that we don't respond to, send
      # them to the interal array.
      #
      # @return [Object]
      def method_missing(method, *args, &block)
        @code.public_send(method, *args, &block)
      end
    
    end
  end
end
