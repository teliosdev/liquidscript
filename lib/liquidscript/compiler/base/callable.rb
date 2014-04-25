module Liquidscript
  module Compiler
    class Base
      class Callable

        attr_accessor :bind

        # Initialize the callable.
        #
        # @param bind [Object] the object that holds the method (if
        #   this represents a method call).
        # @param block [Symbol, Block] if it's a Symbol, it represents
        #   a method on bind; otherwise, it's a pure block.
        def initialize(bind, block, prefix = "compile_")
          @bind = bind
          @block = if block.is_a? Symbol
            :"#{prefix}#{block}"
          else
            block
          end
        end

        # Calls the thing that this represents.  If this represents a
        # method call, it calls the method with the given arguments;
        # otherwise, it calls {#call} on the block.
        #
        # @param args [Object] passed to the call.
        # @return [Object] the result of the call.
        def call(*args)
          if @block.is_a? Symbol
            @bind.public_send(@block, *args)
          elsif @block.respond_to?(:call)
            @block.call(*args)
          end
        end

        # This applies only as many arguments as the block or function
        # needs.  This is just so that calling a method is easier,
        # so the developer doesn't have to worry about arity and
        # such.
        #
        # @param args [Object] passed to the call.
        # @return [Object] the result of the call.
        def apply(*args)
          return call if arity == 0

          if block_given?
            call(*yield[0..arity])
          else
            call(*args[0..arity])
          end
        end

        # How many arguments the call can take.  If this represents a
        # block that has tricks enabled, then this isn't an issue; if
        # it's a method call, however, it becomes important.
        #
        # @return [Numeric] the number of arguments it can take.
        def arity
          if @block.is_a? Symbol
            @bind.method(@block).arity
          else
            @block.arity
          end
        end

      end
    end
  end
end
