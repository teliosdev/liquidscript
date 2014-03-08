module Liquidscript
  module Compiler
    class ICR < Base
      module Functions

        def compile_property(prop)
          shift :prop

          ref = if [:identifier, :class, :module].include?(prop.type)
            ref(prop)
          else
            prop
          end

          property = action do |ident|
            code :property, ref, ident
          end

          # Just in case there is a property named 'class' or 'module'
          code = expect [:identifier, :class, :module] => property

          expect :lparen => action { compile_call(code)       },
                 :equal  => action { compile_assignment(code) },
                 :prop   => action { compile_property(code)   },
                 :_      => action { code                     }
        end

        def compile_call(subject)
          shift :lparen

          arguments = collect_compiles :expression, :rparen,
            :comma => action.shift

          code :call, subject, *arguments
        end
      end
    end
  end
end
