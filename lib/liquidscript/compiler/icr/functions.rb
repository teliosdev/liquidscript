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

          v
        end

        def compile_access(body)
          shift :lbrack
          key = compile_vexpression
          shift :rbrack

          v = code :access, body, key

          v
        end

        def compile_call(subject)
          shift :lparen

          if subject.type == :identifier
            ref(subject)
          end

          arguments = collect_compiles :expression, :rparen,
            :comma => action.shift

          call = code :call, subject, *arguments
          call
        end

        protected

        def value_expect(v, &default)
          out = expect \
                 :lparen => action { compile_call(v)       },
                 :equal  => action { compile_assignment(v) },
                 :prop   => action { compile_property(v)   },
                 :lbrack => action { compile_access(v)     },
                 [:binop,
                  :minus,
                  :plus] => action { compile_binop(v)      },
                 :unop   => action { |o| code :op, v, o    },
                 :_      => default || action { v          }

          if out != v
            value_expect(out)
          else
            out
          end
        end
      end
    end
  end
end
