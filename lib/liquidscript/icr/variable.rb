module Liquidscript
  module ICR

    # Represents a variable.  It can hold a value, but it will not
    # be used to reconstruct the variable itself.
    class Variable

      # The context in which this variable exists.  The variable
      # should exist in one and only one context, but can be used
      # in contexts other than its own.
      #
      # @return [Context]
      attr_reader :context

      # The name of the variable that this represents.  This will
      # be used in both ICR and in the final output.
      #
      # @return [Symbol]
      attr_reader :name

      # The set that describes the value of this variable.  The
      # set just so happens to describe the value of the variable;
      # it is not used to define the variable's value.
      #
      # @return [Code]
      attr_accessor :value

      include Representable

      def initialize(context, name, options = {})
        @context = context
        @name    = name
        @options = options
        @value   = nil
      end

      # Make this class compatible with the #type based system.
      #
      # @return [Symbol]
      def type
        :variable
      end

      # Marks this variable as an argument to a function.  This is to
      # let the context know not to show it in certain cases.
      #
      # @return [self]
      def parameter!
        @parameter = true
        self
      end

      # Whether or not the variable is an argument to a function.
      #
      # @see {#parameter!}
      # @return [Boolean]
      def parameter?
        @parameter
      end

      def to_s
        if @options[:class]
          "this.#{@name}"
        else
          @name
        end
      end

      # Turns the variable into an array.
      #
      # @return [Array<(Symbol, Symbol)>]
      def to_a
        [:_variable, @name]
      end
    end
  end
end
