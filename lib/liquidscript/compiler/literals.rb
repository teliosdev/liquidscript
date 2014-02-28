module Liquidscript
  class Compiler
    module Literals

      def compile_number
        code :number, pop.value
      end

      def compile_identifier(identifier)
        default = action do
          code :get, top.context.get(identifier.value.intern)
        end

        expect :equal => action { compile_assignment(identifier) },
               :prop  => action { compile_property(identifier)   },
               :_     => default
      end

      def compile_dstring
        code :dstring, pop.value[1..-2]
      end

      def compile_sstring
        code :sstring, pop.value[1..-1]
      end

      def compile_object
        shift :lbrack

        objects = []
        compile_object = action do
          objects << [compile_object_key, compile_expression]
        end

        loop do
          expect :rbrack => action.end_loop,
          :comma         => action.shift,
          :identifier    => compile_object,
          :dstring       => compile_object
        end

        code :object, objects
      end

      def compile_object_key
        key = shift :identifier, :dstring
        shift :colon

        key
      end

      def compile_function(components)
        shift :arrow
        shift :lbrack

        expressions = ICR::Set.new
        expressions.context = ICR::Context.new
        expressions.context.parent = top.context
        expressions.metadata[:arguments] = components

        @set << expressions

        expression = action do
          expressions << compile_expression
        end

        loop do
          expect :rbrack => action.end_loop,
            :_           => expression
        end

        code :function, @set.pop
      end

    end
  end
end
