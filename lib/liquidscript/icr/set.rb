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

      include Representable

      # Initialize the set.
      def initialize
        @metadata = {}
        @code = []
      end

      #
      def context
        @metadata.fetch(:context) do
          @metadata.fetch(:parent).context
        end
      end

      #
      def context=(new_context)
        @metadata[:context] = new_context
      end

      # Adds a code to the code list.  This is just a
      # convienince method.
      #
      # @param action [Symbol] a symbol representing
      #   the action.
      # @param arguments the arguments for the code.
      def add(action, *arguments)
        @code << Code.new(action, arguments)
      end

      # Turns the set into an array.  Includes the
      # metadata information and the actual internal
      # array.
      # Note that this is _not_ the array used in
      # {#method_missing} - that actually operates on
      # the internal array.
      #
      # @return [Array]
      def to_a
        [
          *@metadata.to_a.map { |(m, i)| [:"_#{m}", i] },
          *@code
        ]
      end

      # Outputs the codes in this set.
      #
      # @return [Array<Code>]
      def codes
        @code
      end

      # Access either the metadata or the codes.  If
      # the accessor is a Symbol, it access the metadata;
      # if it the accessor is a Numeric, it access the
      # codes.
      #
      # @param key [Symbol, Numeric] the key.
      # @return [Object]
      def [](key)
        if key.is_a? Numeric
          @code[key]
        else
          @metadata[key]
        end
      end

      # Sets something from the metadata.  Unlike the
      # accessor, it does not distinguish between
      # Numeric and Symbol keys.
      #
      # @param key [Object] the key.
      # @param value [Object] the value.
      # @return [Object]
      def []=(key, value)
        @metadata[key] = value
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
