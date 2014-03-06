module Liquidscript
  module Generator
    class Javascript
      module Metas

        def generate_exec(code)

          exec = buffer
          exec << _exec_context(code)
          code.codes.inject(exec) do |m, c|
            m << replace(c)
            m
          end
        end

        def generate_set(code)
          case code[1].type
          when :variable
            "#{code[1].name} = #{replace code[2]};"
          when :property
            "#{replace code[1]} = #{replace code[2]};"
          end
        end

        def generate_get(code)

          "#{code[1].name}"
        end

        protected

        def _exec_context(code)

          unless code.locals.empty?
            "var #{code.locals.join(',')}; "
          end
        end
      end
    end
  end
end
