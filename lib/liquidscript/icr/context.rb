require "hashie"

module Liquidscript
  module ICR

    # Handles variables within blocks.  Each variable will get a
    # reference in each context.  When retrieving the value of
    # a variable, if the variable was not introduced in the scope,
    # it will look to its parent for the value of the variable.
    # When setting the value of a variable, a new variable is
    # forcibly created.
    class Context

      # The variables that are allowed to be used as a global scope,
      # i.e. used in a `get` context without a previous `set`.
      DEFAULT_ALLOWED_VARIABLES = [
        :window, :global, :exports, :console, :this, :arguments
      ]

      # The parent of the current context.
      #
      # @return [Parent]
      attr_accessor :parent

      # The variables that are a part of this context.
      #
      # @return [Hash<Symbol, Variable>]
      attr_reader :variables

      # The variables that are allowed to be used as a global scope,
      # i.e. used in a `get` context without a previous set.
      #
      # @see [DEFAULT_ALLOWED_VARIABLES]
      # @return [Array<Symbol>]
      attr_reader :allowed_variables

      include Representable

      # Initializes the context.
      def initialize
        @variables = {}
        @allowed_variables = [DEFAULT_ALLOWED_VARIABLES].flatten
      end

      # Returns a variable reference.  If checks the local variables
      # first; if it doesn't exist there, then if the type is `:get`,
      # checks the parent; otherwise, sets the value of the variable.
      # If there is no parent and the type is `:get`, it raises an
      # {InvalidReferenceError}.
      #
      # @param name [Symbol] the name of the variable.
      # @param type [Symbol] the type of use.  Should be `:get` or
      #   `:set`.
      # @return [Variable]
      def variable(name, type)
        @variables.fetch(name) do
          if type == :set
            @variables[name] = Variable.new(self, name)
          elsif allowed_variables.include?(name)
            Variable.new(self, name)
          elsif type == :get && parent
            parent.get(name)
          else
            raise InvalidReferenceError.new(name)
          end
        end
      end

      # Allows a specific variable to be used - but doesn't define it
      # in the current context.
      #
      # @param name [Symbol]
      # @return [void]
      def allow(name)
        allowed_variables << name
      end

      # All of the parameter variables.
      #
      # @return [Array<Variable>]
      def parameters
        @variables.values.select(&:parameter?)
      end

      # (see #variable).
      #
      # Passes `:get` as type.
      def get(name)
        variable(name, :get)
      end

      # (see #variable).
      #
      # Passes `:set` as type.
      def set(name)
        variable(name, :set)
      end

      def to_a
        @variables.keys
      end

    end
  end
end
