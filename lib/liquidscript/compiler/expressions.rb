module Liquidscript
  class Compiler
    module Expressions

      def compile_expression
        expect :number, :identifier
      end

      def compile_number
        ICR::Code.new :number, pop.value
      end

      def compile_identifier(identifier)
        if peek.type?(:equal)
          compile_assignment(identifier)
        else
          ICR::Code.new :get, top.context.get(identifier.value.intern)
        end
      end

      def compile_dstring
        ICR::Code.new :dstring, pop.value[1..-2]
      end

      def compile_sstring
        ICR::Code.new :sstring, pop.value[1..-1]
      end

      def compile_assignment(identifier)
        _, value, name, ref = pop, compile_expression,
          identifier.value.intern, top.context.set(name)

        ref.value = value

        ICR::Code.new :set, ref, value
      end

    end
  end
end
