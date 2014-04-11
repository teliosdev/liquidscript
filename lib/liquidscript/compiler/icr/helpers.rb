module Liquidscript
  module Compiler
    class ICR < Base
      module Helpers

        def ref(literal)
          top.context.get(literal.value.intern)
        end

        def set(literal)
          top.context.set(literal.value.intern)
        end

        def code(type, *args)
          Liquidscript::ICR::Code.new type, *args
        end

        def _compile_block
          if peek?(:lbrace)
            shift :lbrace
            collect_compiles(:expression, :rbrace)
          else
            compile_expression
          end
        end

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
