module Liquidscript
  class Compiler
    module Literals
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

      def compile_object
        shift_if :lbrack

        objects = []
        do_loop = true

        while do_loop do
          expect :rbrack => proc { |_|
            do_loop = false
          }, :identifier => proc {
            objects << [compile_object_key, compile_expression]
          }, :comma => proc { |_| }
        end

        ICR::Code.new :object, objects
      end

      def compile_object_key
        key = shift_if :identifier
        shift_if :colon

        key
      end
    end
  end
end
