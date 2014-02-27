module Liquidscript
  class Compiler
    module Expressions

      def compile_expression
        expect :number, :identifier, :sstring,
          :lbrack => :object
      end

      def compile_assignment(identifier)
        pop
        value    = compile_expression
        name     = identifier.value.to_sym
        variable = top.context.set(name)

        variable.value = value

        ICR::Code.new :set, variable, value
      end

    end
  end
end
