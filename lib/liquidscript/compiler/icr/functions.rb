module Liquidscript
  module Compiler
    class ICR < Base
      module Functions

        def compile_property(prop)
          shift :prop

          property = action do |ident|
            code :property, prop, (ident.value || ident.type)
          end

          # Just in case there is a property named 'class' or 'module'
          v = expect [:identifier, :class, :module] => property

          expect :lparen => action { compile_call(v)       },
                 :equal  => action { compile_assignment(v) },
                 :prop   => action { compile_property(v)   },
                 :unop   => action { |o| code :op, v, o    },
                 :_      => action { v                     }
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
