module Liquidscript
  module ICR

    # An individual code point.  This is normally in
    # a set.  A code will have an action, and arguments
    # that accompany that action.  The arguments list
    # can be however long.
    class Code

      # The action that this code is associated with.
      # This should be a symbol.
      #
      # @return [Symbol]
      attr_reader :action

      # The arguments that are used for this action.
      # This is an array.
      #
      # @return [Array]
      attr_reader :arguments

      include Representable

      # Initializes the code.  It takes an action and
      # an argument as its arguments.  The action
      # should not change from this point forward.
      #
      # @param action [Symbol]
      # @param arguments [Array]
      def initialize(action, *arguments)
        @action = action
        @arguments = arguments
      end

      # Turns the code into an array, containing the
      # action and the arguments.  Note that changing
      # this array will not change the code.
      #
      # @return [Array]
      def to_a
        [@action, *@arguments]
      end

      # If we don't respond to it, the @arguments array
      # might.  Ask them if they do, and if they don't,
      # respond accordingly.
      #
      # @param method [Symbol] the method to check.
      # @param include_private [Boolean] whether or not to
      #   include private methods.
      # @return [Boolean]
      def respond_to_missing?(method, include_private = false)
        @arguments.respond_to?(method)
      end

      # Send the method to @arguments if it doesn't
      # exist here.
      #
      # @return [Object]
      def method_missing(method, *args, &block)
        @arguments.public_send(method, *args, &block)
      end

    end
  end
end
