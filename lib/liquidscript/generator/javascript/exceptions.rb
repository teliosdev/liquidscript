module Liquidscript
  module Generator
    class Javascript < Base
      module Exceptions

        def generate_try(code)
          out = buffer
          out << "try {\n"
          insert_into(code[1], out)
          out << indent_level << "}"

          if code[2]
            out << replace(code[2])
          end

          out
        end

        def generate_catch(code)
          out = buffer
          out << "catch(#{code[1].value}) {\n"
          insert_into(code[2], out)
          out << indent_level << "}"

          if code[3]
            out << replace(code[3])
          end

          out
        end

        def generate_finally(code)
          out = buffer
          out << "finally {\n"
          insert_into(code[1], out)
          out << indent_level << "}"
        end

      end
    end
  end
end
