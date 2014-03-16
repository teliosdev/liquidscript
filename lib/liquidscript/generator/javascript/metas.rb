module Liquidscript
  module Generator
    class Javascript
      module Metas

        def generate_exec(code)
          exec = buffer
          exec << _exec_context(code)
          insert_into(code.codes, exec)
        end

        def generate_set(code)
          case code[1].type
          when :variable
            "#{code[1].name} = #{replace code[2]}"
          when :property, :access
            "#{replace code[1]} = #{replace code[2]}"

          end
        end

        def generate_access(code)
          "#{replace code[1]}[#{replace code[2]}]"
        end

        def generate_get(code)
          "#{code[1].name}"
        end

        { :if     => "if(%s)",
          :elsif  => "else if(%s)",
          :unless => "if(!(%s))" }.each do |k, v|

          define_method(:"generate_#{k}") do |code|
            part = buffer
            part << "#{v % replace(code[1])} {\n"
            indent!
            insert_into(code[2], part)
            unindent!
            part << indent_level << "}"

            if code[3]
              part << replace(code[3])
            else
              part
            end
          end
        end

        def generate_else(code)
          part = buffer
          part << " else {\n"
          indent!
          insert_into(code[1], part)
          unindent!
          part << indent_level << "}"
        end

        protected

        def _exec_context(code)

          unless code.locals.empty?
            "\n#{indent_level}var #{code.locals.join(',')};\n"
          end
        end
      end
    end
  end
end
