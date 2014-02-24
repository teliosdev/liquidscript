module Liquidscript
  class Compiler
    module Expressions

      def compile_expression
        case peek.type
        when :number
          compile_number
        else
          error
        end
      end

      def compile_number
        buffer.append pop.value
      end

    end
  end
end
