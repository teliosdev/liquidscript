module Liquidscript
  module Generator
    class Javascript < Base
      module Literals

        BINOP_SWITCH = {
          "=="  => "===",
          "===" => "==",
          "!="  => "!==",
          "!==" => "!=",
          "or"  => "||",
          "and" => "&&"
        }.freeze

        def generate_number(code)
          "#{code.first}"
        end

        def generate_istring(code)
          "\"#{code.first.gsub("\n", "\\n")}\""
        end

        def generate_interop(code)
          content = code[1..-1]
          buf = buffer

          content.each do |part|
            case part.type
            when :istring_begin, :istring
              buf << "\"#{part.value}\""
            else
              buf << " + (#{replace(part)}) + "
            end
          end

          buf
        end

        def generate_sstring(code)

          "'#{code.first.gsub(/'/, "\\'")}'"
        end

        def generate_unop(code)
          " #{code[1].value} #{replace(code[2])}"
        end

        def generate_href(code)
          heredoc = code[1]
          hbuf = buffer

          heredoc.body.each do |part|
            case part.type
            when :heredoc, :iheredoc, :iheredoc_start
              hbuf << '"' << part.value.gsub('"', '\\"') << '"'
            else
              hbuf << ' + ' << replace(part) << ' + '
            end
          end

          hbuf
        end

        def generate_binop(code)
          op = BINOP_SWITCH.fetch(code[1].value) do
            code[1].value
          end

          " #{replace(code[2])} #{op} #{replace(code[3])}"
        end

        def generate_keyword(code)
          " #{code[1].value} "
        end

        def generate_object(code)

          object = buffer
          object.set_join! ', '
          indent!

          code[1].inject(object) do |buf, part|
            buf << "#{indent_level}\"#{part[0].value}\": #{replace(part[1])}"
          end

          unindent!
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

        def generate_newline(_)
          ""
        end

        def generate_function(code)

          function = buffer
          indent!

          function                       <<
            "function("                  <<
            code[1].parameters.join(',') <<
            ') {'                        <<
            replace(code[1])             <<
            '}'

          unindent!
          function
        end
      end
    end
  end
end
