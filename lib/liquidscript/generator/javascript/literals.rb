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
          "and" => "&&",
          "is"  => "===",
          "isnt"=> "!=="
        }.freeze

        def generate_number(code)
          "#{code.first}"
        end

        def generate_nrange(code)
          start  = code[1]
          ending = code[2]

          buffer << "[" << (start..ending).to_a.join(', ') << "]"
        end

        def generate_range(code)
          out = buffer
          out << "(function(a, b) {\n"                          <<
                 indent!   << "var out, i;\n"                   <<
                 indent    << "for(i = a; i <= b; i++) {\n"     <<
                 indent!   << "out.push(i);\n"                  <<
                 unindent! << "};\n"                            <<
                 indent    << "return out;\n"                   <<
                 unindent! << "})(" << replace(code[1]) << ", " <<
                 replace(code[2]) << ")"
          out
        end

        def generate_action(code)
          code[1].value
        end

        def generate_op(code)
          "#{replace(code[1])}#{code[2].value}"
        end

        def generate_neg(code)
          "-#{replace(code[1])}"
        end

        def generate_pos(code)
          "+#{replace(code[1])}"
        end

        def generate_while(code)
          loop_body = buffer
          loop_body << "while(#{replace(code[1])}) {\n"
          insert_into(code[2], loop_body)
          loop_body << indent_level << "}"
        end

        def generate_for_in(code)
          loop_body = buffer
          loop_body << "for(#{code[1].to_s} in #{code[2].name}) {\n"
          indent!
          insert_into(code[3], loop_body)
          unindent!
          loop_body << indent << "}"
        end

        def generate_for_seg(code)
          loop_body = buffer
          loop_body << "for("            <<
                       replace(code[1])  << "; " <<
                       replace(code[2])  << "; " <<
                       replace(code[3])  << ") {\n"

          indent!
          insert_into(code[4], loop_body)
          unindent!

          loop_body << indent_level << "}"
        end

        def generate_regex(code)
          "/#{code[1].value[0]}/#{code[1].value[1]}"
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
          "#{code[1].value} #{replace(code[2])}"
        end

        def generate_href(code)
          heredoc = code[1]
          hbuf = buffer

          heredoc.body.each do |part|
            case part.type
            when :heredoc, :iheredoc, :iheredoc_begin
              hbuf << '"' << part.value.gsub('"', '\\"') << '"'
            else
              hbuf << ' + ' << replace(part) << ' + '
            end
          end

          hbuf
        end

        def generate_binop(code)
          op = BINOP_SWITCH.fetch(code[1].value) do
            case code[1].type
            when :minus
              '-'
            when :plus
              '+'
            else
              code[1].value
            end
          end

          "#{replace(code[2])} #{op} #{replace(code[3])}"
        end

        #def generate_identifier(code)
        #  code.value
        #end

        def generate_variable(code)
          code.to_s
        end

        def generate_keyword(code)
          "#{code[1].value}"
        end

        def generate_object(code)

          object = buffer
          object.set_join! ",\n#{indent!}"

          code[1].inject(object) do |buf, part|
            buf << "\"#{part[0].value}\": #{replace(part[1])}"
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

          function                        <<
            "function("                   <<
            code[1].parameters.join(', ') <<
            ") {\n"                       <<
            replace(code[1])
          unindent!

          function << indent_level << "}"
        end
      end
    end
  end
end
