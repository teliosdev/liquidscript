module Liquidscript
  module ICR

    # Handles variables within blocks.  Each variable will get a
    # reference in each context.  When retrieving the value of
    # a variable, if the variable was not introduced in the scope,
    # it will look to its parent for the value of the variable.
    # When setting the value of a variable, a new variable is
    # forcibly created.
    class Context

      # The parent of the current context.
      #
      # @returns [Parent]
      attr_accessor :parent

      include Representable

      # Initializes the context.
      def initialize
        @variables = {}
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
      # @returns [Variable]
      def variable(name, type)
        @variables.fetch(name) do
          if type == :get && parent
            parent.get(name)
          elsif type == :set
            raise StandardError if name == nil
            @variables[name] = Variable.new(self, name)
          else
            raise InvalidReferenceError.new(name)
          end
        end
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
