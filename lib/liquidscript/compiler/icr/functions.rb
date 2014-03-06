module Liquidscript
  module Compiler
    class ICR < Base
      module Functions

        def compile_property(prop)
          shift :prop

          ref = if prop.type == :identifier
            ref(prop)
          else
            prop
          end

          property = action do |ident|
            code :property, ref, ident
          end

          code = expect :identifier => property

          expect :lparen => action { compile_call(code)       },
                 :equal  => action { compile_assignment(code) },
                 :prop   => action { compile_property(code)   },
                 :_      => action { code                     }
        end

        def compile_call(subject)
          shift :lparen
          arguments = []

          loop do
            expect :comma  => action.shift,
                   :rparen => action.end_loop,
                   :_      => action { arguments << compile_expression }
          end

          code :call, subject, *arguments
        end
      end
    end
  end
end
