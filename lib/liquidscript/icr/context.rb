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
      DEFAULT_ALLOWED_VARIABLES = %w(
        window global exports console this arguments
        Infinity NaN undefined eval isFinite isNaN parseFloat
        parseInt decodeURI decodeURIComponent encodeURI encodeURIComponent
        Object Function Boolean Error EvalError InternalError RangeError
        ReferenceError SyntaxError TypeError URIError Number Math
        Date String  RegExp Array Float32Array Float64Array Int16Array
        Int32Array Int8Array Uint16Array Uint32Array Uint8Array
        Uint8ClampedArray ArrayBuffer DataView JSON Intl
      ).map(&:intern)

      # The parent of the current context.
      #
      # @return [Parent]
      attr_accessor :parents

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

      attr_reader :undefined

      include Representable

      # Initializes the context.
      def initialize
        @undefined = []
        @variables = {}
        @allowed_variables = [DEFAULT_ALLOWED_VARIABLES].flatten
        @parents = []
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
      def variable(name, type, options = {})
        if [:get, :set].include?(type)
          send(type, name, options = {})
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
      def get(name, options = {})
        @variables.fetch(name) do
          case true
          when allowed_variables.include?(name)
            Variable.new(self, name)
          when parents.any?
            get_parent(name)
          when @class
            add_undefined(name)
          else
            raise InvalidReferenceError.new(name)
          end
        end
      end

      # (see #variable).
      #
      # Passes `:set` as type.
      def set(name, options = {})
        @variables.fetch(name) do
          @undefined.reject! { |(n, _)| n == name }
          @variables[name] =
            Variable.new(self, name,
                         {:class => @class}.merge(options))
        end
      end

      def class!
        @class = true
        self
      end

      def to_a
        @variables.keys
      end

      private

      def get_parent(name)
        results = parents.map do |parent|
          begin
            parent.get(name)
          rescue InvalidReferenceError => e
            e
          end
        end.compact

        where = results.detect { |i|
          not i.is_a?(InvalidReferenceError) }

        if where
          where
        else
          error = results.first
          if @class
            add_undefined(name, error)
          else
            raise error
          end
        end
      end

      def add_undefined(name, e = InvalidReferenceError.new(name))
        @undefined << [name, e]
        Variable.new(self, name, :class => true)
      end
    end

  end
end
