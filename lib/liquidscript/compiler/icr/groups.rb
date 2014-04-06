module Liquidscript
  module Compiler
    class ICR < Base
      module Groups

        def _compile_group(type, cond = false, continue = false)
          shift type

          if cond ||= block_given?
            shift :lparen
            if block_given?
              conditional = yield
            else
              conditional = compile_vexpression
            end
            shift :rparen
          end

          if continue && !continue.is_a?(Array)
            continue = [:elsif, :else]
          end

          shift :lbrace
          body = collect_compiles(:expression, :rbrace)

          args = [type]
          args << conditional if cond
          args << body
          args << expect(*continue) if continue and peek?(*continue)

          code(*args)
        end

        private :_compile_group

        def compile_if
          _compile_group(:if, true, true)
        end

        def compile_elsif
          _compile_group(:elsif, true, true)
        end

        def compile_unless
          _compile_group(:unless)
        end

        def compile_else
          _compile_group(:else, false)
        end

        def compile_try
          _compile_group(:try, false, [:catch, :finally])
        end

        def compile_catch
          _compile_group(:catch, false, [:finally]) do
            shift :identifier
          end
        end

        def compile_finally
          _compile_group(:finally)
        end
      end
    end
  end
end
