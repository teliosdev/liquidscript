module Liquidscript
  module Compiler
    class ICR < Base
      module Functions

        def compile_property(identifier)
          shift :prop

          property = action do |ident|
            code :property, ref(identifier), ident
          end

          code = expect :identifier => property

          expect :lparen => action { compile_call(code) },
                 :_      => action { code }
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
