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

      extend Forwardable

      def_delegators :to_a, :inspect, :to_s

      def initialize(context, name)
        @context = context
        @name = name
        @value = nil
      end

      # Turns the variable into an array.
      #
      # @return [Array<(Symbol, Symbol, Set)>]
      def to_a
        [:_variable, @name, @value]
      end
    end
  end
end
