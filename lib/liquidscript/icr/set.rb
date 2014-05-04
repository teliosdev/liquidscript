module Liquidscript
  module ICR

    # Represents a set of instruction codes.  Can contain
    # metadata about the set, like whether or not it can
    # be inlined, if a new context needs to be applied,
    # etc.
    class Set < Code

      include Representable

      # Initialize the set.
      def initialize
        @context = nil
        super :exec
      end

      #
      def context
        @context || @metadata.fetch(:parent).context
      end

      def parent=(parent)
        @metadata[:parent] = parent
        if @context
          @context.parent = parent.context
        end

        parent
      end

      #
      def context=(context)
        @context = context
      end

      # Turns the code into an array, containing the
      # action and the arguments.  Note that changing
      # this array will not change the code.
      #
      # @return [Array]
      def to_a
        part = [@action]
        part << [:_context, context] if @context
        part.concat(@metadata.to_a.select { |(k, v)|
          [:arguments, :heredocs, :herenum].include?(k)
          }.map { |(k, v)| [:"_#{k}", v] })
        part.concat(@arguments)
        part
      end

      # Adds a code to the code list.  This is just a
      # convienince method.
      #
      # @param action [Symbol] a symbol representing
      #   the action.
      # @param arguments the arguments for the code.
      def add(action, *arguments)
        self << Code.new(action, arguments)
      end

      def <<(*v)
        v.select { |p| p }.each do |part|
          @arguments << part
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
        variables - parameters - hidden
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

      # A list of hidden variables in the current
      # context.
      #
      # @return [Array<Symbol>]
      def hidden
        context.hidden.map(&:name)
      end

      # A list of _all_ variables in the current
      # scope.
      #
      # @return [Array<Symbol>]
      def variables
        context.variables.keys - context.allowed_variables
      end

      # Outputs the codes in this set.
      #
      # @return [Array<Code>]
      def codes
        @arguments
      end

    end
  end
end
