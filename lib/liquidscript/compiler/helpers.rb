module Liquidscript
  class Compiler
    module Helpers

      def pop
        @scanner.next
      rescue StopIteration
        Scanner::NilToken.new
      end

      def action(act = nil)
        if block_given?
          Proc.new
        elsif act.is_a? Proc
          act
        else
          @action
        end
      end

      def loop
        result = true

        while result
          result = yield
        end
      end

      def peek
        @scanner.peek
      rescue StopIteration
        Scanner::NilToken.new
      end

      def code(type, *args)
        ICR::Code.new type, *args
      end

      def shift(*types)
        if peek?(*types)
          pop
        else
          raise UnexpectedError.new(types, peek.type)
        end
      end

      def peek?(*types)
        types.any? { |type| peek.type? type }
      end

      def expect(*args)
        hash = if args.last.is_a? Hash
          args.pop
        else
          {}
        end

        args.each do |arg|
          hash[arg] = arg
        end

        block = hash.fetch(peek.type) do
          hash.fetch(:_)
        end

        if block.is_a? Symbol
          block = method(:"compile_#{block}")
        end

        if block.respond_to?(:call)
          if block.respond_to?(:arity) && block.arity == 1
            block.call pop
          else
            block.call
          end
        end

        # discard it...

      rescue KeyError
        raise UnexpectedError.new(hash.keys, peek.type)
      end
    end
  end
end
