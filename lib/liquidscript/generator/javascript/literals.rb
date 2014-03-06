module Liquidscript
  module Generator
    class Javascript < Base
      module Literals

        def generate_number(code)

          "#{code.first}"
        end

        def generate_dstring(code)

          "\"#{code.first.gsub(/"/, '\\"')}\""
        end

        def generate_sstring(code)

          "'#{code.first.gsub(/'/, "\\'")}'"
        end

        def generate_keyword(code)
          " #{code[1].value} #{replace(code[2])}"
        end

        def generate_object(code)

          object = buffer
          object.set_join! ', '

          code[1].inject(object) do |buf, part|
            buf << "\"#{part[0].value}\": #{replace(part[1])}"
          end

          "{#{object}}"
        end

        def generate_array(code)

          array = buffer
          array.set_join! ', '

          code[1].inject(array) do |a, p|
            a << replace(p)
          end

          "[#{array}]"
        end

        def generate_function(code)

          function = buffer

          function                       <<
            "function("                  <<
            code[1].parameters.join(',') <<
            ') {'                        <<
            replace(code[1])             <<
            '}'
        end
      end
    end
  end
end
