module Liquidscript
  module ICR

    # Represents a set of instruction codes.  Can contain
    # metadata about the set, like whether or not it can
    # be inlined, if a new context needs to be applied,
    # etc.
    class Set < Code

      # The metadata that is applied to the set.
      #
      # @return [Hash]
      attr_reader :metadata

      include Representable

      # Initialize the set.
      def initialize
        @metadata = {}
        @code = []
        @contexts = []
        @action = :exec
      end

      #
      def context
        contexts.last || @metadata.fetch(:parent).context
      end

      def contexts
        @contexts
      end

      #
      def context=(new_context)
        contexts << new_context
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

      def <<(*v)
        v.select { |p| p }.each do |part|
          @code << part
        end
      end

      alias_method :push, :<<

      # A list of all the local variables in the
      # current scope.  Local variables are defined
      # as variables that were a) not passed in by
      # function execution as arguments and b) are
      # set within the current context.
      #
      # @return [Array<Symbol>]
      def locals
        variables - parameters
      end

      # A list of components (or arguments) that are
      # in the current scope.  Defined as variables
      # that were passed in by function execution as
      # arguments.
      #
      # @return [Array<Symbol>]
      def parameters
        context.parameters.map(&:name)
      end

      # A list of _all_ variables in the current
      # scope.
      #
      # @return [Array<Symbol>]
      def variables
        context.variables.keys - context.allowed_variables
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
        part = [@action]
        part << [:_context, context] if contexts.any?
        part.concat(@metadata.to_a.map { |(m, i)| [:"_#{m}", i] })
        part.concat(@code)
        part
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
