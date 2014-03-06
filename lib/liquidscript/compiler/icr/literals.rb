module Liquidscript
  module Compiler
    class ICR < Base
      module Literals

        def compile_number
          code :number, pop.value
        end

        def compile_identifier(identifier)
          default = action do
            code :get, ref(identifier)
          end

          expect :equal  => action { compile_assignment(identifier) },
                 :prop   => action { compile_property(identifier)   },
                 :lparen => action { compile_call(identifier)       },
                 :_      => default
        end

        def compile_dstring
          code :dstring, pop.value[1..-2]
        end

        def compile_sstring
          code :sstring, pop.value[1..-1]
        end

        def compile_keyword
          code :keyword, shift(:keyword), compile_expression
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
            [:identifier, :dstring] => compile_object
          end

          code :object, objects
        end

        def compile_array
          shift :lbrace

          parts = []
          compile_part = action { parts << compile_expression }

          loop do
            expect :rbrace => action.end_loop,
            :comma         => action.shift,
            :_             => compile_part
          end

          code :array, parts
        end

        def compile_object_key
          key = shift :identifier, :dstring
          shift :colon

          key
        end

        def compile_function
          compile_function_with_parameters([])
        end

        def compile_function_with_parameters(parameter)
          shift :arrow
          shift :lbrack

          expressions = Liquidscript::ICR::Set.new
          expressions.context = Liquidscript::ICR::Context.new
          expressions.context.parent = top.context
          expressions[:arguments] = parameter
          @set << expressions

          parameter.each do |parameter|
            set(parameter).parameter!
          end


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
end
