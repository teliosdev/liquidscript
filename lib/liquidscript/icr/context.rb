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

      include Representable

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
      ).map(&:intern).freeze

      attr_accessor :parent
      attr_reader :variables

      def initialize
        @variables = {}
        @undefined = []
      end

      def allowed_variables
        DEFAULT_ALLOWED_VARIABLES
      end

      # If the context delegates setting variables to its parents.
      # This keeps this context from getting any variables set on
      # it, and instead sets variables on the parent.
      #
      # @see {#delegate!}
      # @return [Boolean]
      def delegate?
        @delegate
      end

      # Sets whether or not the context will delegate setting
      # variables to its parent.
      #
      # @see {#delegate?}
      # @return [Boolean]
      def delegate!
        @delegate = !delegate?
      end

      # Delegates a block, such that the contents don't affect
      # the current context.
      #
      # @return [Object] the value of the block
      def delegate
        old, @delegate = @delegate, true
        out = yield
        @delegate = old
        out
      end

      # If this context is associated with a class.  The context
      # will forward any errors until after the context is completely
      # finalized.
      #
      # @see {#class!}
      # @return [Boolean]
      def class?
        @class
      end

      # Sets this context to be associated with a class.
      # @see {#class?}
      # @return [Boolean]
      def class!
        @class = true
      end

      # Retrieves a reference to a variable.  If the local
      # context doesn't have a reference, then it will try
      # a few things; first, it will check to see if that
      # variable is one of our allowed variables; second,
      # it will check if the parent has a reference; otherwise,
      # it will add an undefined reference if this context
      # is associated with a class.
      #
      # @see {#parent}
      # @see {#allowed_variables}
      # @see {#add_undefined}
      # @see {#variables}
      # @param name [Symbol] the variable to reference.
      # @param options [Hash] Extra options.
      # @option options [Boolean] :dry_run if this is a dry
      #   run.  In that case, it won't add an undefined
      #   reference.
      # @raise [InvalidReferenceError] if the variable could
      #   not be handled correctly.
      # @return [Variable, Boolean]
      def get(name, options = {})
        variables.fetch(name) do
          case true
          # If the asking variable is an allowed variable, we'll
          # allow it, and just return a variable instance.
          when allowed_variables.include?(name)
            Variable.new(self, name, :allowed => true)
          # If we have a parent, we can ask the parent for the
          # variable.  This takes precedence over the class
          # so we can get a proper reference to the correct
          # variable.
          when !!parent
            parent_get(name, options)
          # If this context is associated with a class, and
          # we're not doing a dry run, then we'll add an
          # undefined.
          when @class && !options[:dry_run]
            add_undefined(name)
          # If we are doing a dry run, however, then just let
          # the caller know that it would have been successful.
          when @class && options[:dry_run]
            true
          # If none of those options fit, raise an error.
          else
            raise InvalidReferenceError.new(name)
          end
        end
      end

      # If this context delegates, it delegates to the parent;
      # otherwise, it will check if we have set this variable
      # before.  Otherwise, it will first reject any undefined
      # variables that existed with the specific name, and then
      # create a new variable with the given options.
      #
      # @see {#variables}
      # @see {#parent}
      # @see {#delegate?}
      # @param name [Symbol] the name of the variable.
      # @param options [Hash] the options to pass to the new
      #   variable instance.
      # @return [Variable]
      def set(name, options = {})
        return parent.set(name, options) if delegate?

        variables.fetch(name) do
          @undefined.reject! { |(n, _)| n == name }
          variables[name] = Variable.new(self, name,
            { :class => class? }.merge(options))
        end
      end

      # Retrieves all of the variables that are parameters
      # in the current context.
      #
      # @see {Variable#parameter?}
      # @return [Array<Variable>]
      def parameters
        variables.values.select(&:parameter?)
      end

      # Retrieves all of the variables that are hidden in
      # the current context.
      #
      # @see {Variable#hidden?}
      # @return [Array<Variable>]
      def hidden
        variables.values.select(&:hidden?)
      end

      # Returns the name of the variables in this context.
      #
      # @return [Array<Symbol>]
      def to_a
        variables.keys
      end

      # Check if there are any undefined variables, and if
      # there are, raise the first one it sees.
      #
      #
      def force_defined!
        @undefined.each { |f| raise f[1] }
      end

      private

      # Retrieves a variable from a parent.  If this context
      # is associated with a class, it will add an undefined
      # variable if the parent raises an
      # InvalidReferenceError.  Otherwise, it will just allow
      # the error to be raised.
      #
      # @see {#parent}
      # @see {#add_undefined}
      # @raise [InvalidReferenceError]
      # @param name [Symbol] the name of the variable.
      # @param options [Hash] the options to be passed to the
      #   parent.
      # @return [Variable]
      def parent_get(name, options)
        parent.get(name, options)

      rescue InvalidReferenceError => e
        if class? && !options[:dry_run]
          add_undefined(name, e)
        else
          raise
        end
      end

      # Adds an undefined variable to the list.  If there are
      # any at the end of compiling, then the corresponding
      # errors will be raised.  This only applies if the context
      # is associated with a class.
      #
      # @see {#class?}
      # @param name [Symbol] the name of the variable.
      # @param error [InvalidReferenceError] the error to be
      #   raised if the undefined variable is not defined
      #   by the end of compilation.
      # @return [Variable]
      def add_undefined(name, error = InvalidReferenceError.new(name))
        @undefined << [name, error]
        Variable.new(self, name, :class => true)
      end

    end

  end
end
