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

        { :if     => "if(%s)",
          :elsif  => "else if(%s)",
          :unless => "if(!(%s))" }.each do |k, v|

          define_method(:"generate_#{k}") do |code|
            part = buffer
            part << "\n#{v % replace(code[1])} {\n"
            code[2].inject(part) { |m, p| m << replace(p) }
            part << "\n}\n"

            if code[3]
              part << replace(code[3])
            else
              part
            end
          end
        end

        def generate_else(code)
          part = buffer
          part << "\nelse {\n"
          code[1].inject(part) { |m, p| m << replace(p) }
          part << "\n}\n"
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
