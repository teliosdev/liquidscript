module Liquidscript
  class Compiler
    module Expressions

      def compile_expression
        expect :number
      end

      def compile_number
        buffer.append pop.value
      end

    end
  end
end
