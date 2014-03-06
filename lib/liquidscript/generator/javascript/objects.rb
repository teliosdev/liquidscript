module Liquidscript
  module Generator
    class Javascript
      module Objects

        def generate_expression(code)
          "(#{replace(code[1].first)})"
        end

        def generate_call(code)
          call = buffer
          args = buffer
          args.set_join! ','

          case code[1].type
          when :identifier
            call << "#{code[1].value}"
          else
            call << "#{replace(code[1])}"
          end

          code[2..-1].inject(args) do |b, arg|
            b << replace(arg)
          end

          call << "(" << args << ")"
        end

        def generate_property(code)
          prop = buffer

          case code[1].type
          when :identifier
            prop << code[1].value
          when :variable
            prop << code[1].name
          else
            prop << replace(code[1])
          end

          prop << "." << code[2].value
        end

        def generate_class(code)
          body       = buffer
          class_name = code[1].value

          in_module(class_name) do |last_module|
            body                                          <<
              "#{class_name} = function #{class_name}(){" <<
              "if(this.initialize) {"                     <<
              "this.initialize.apply(this, arguments);"   <<
              "}};"

            code[2].each do |(k, v)|
              case k.type
              when :identifier
                body                                      <<
                  "#{class_name}.prototype.#{k.value} ="  <<
                  replace(v) << ";"
              when :dstring
                body                                      <<
                  "#{class_name}.prototype[#{k.value}] =" <<
                  replace(v) << ";"
              when :prop
                if k[1].name != :this
                  raise InvalidCodeError.new(v[1].name)
                end

                body                                      <<
                  "#{class_name}.#{k[2].value} = "        <<
                  replace(v) << ";"
              end
            end

            if last_module
              body                                        <<
                "#{last_module}.#{class_name} = "         <<
                "#{class_name};"
            end

          end

          body
        end

        def generate_module(code)
          body = buffer
          module_name = code[1].value

          in_module(module_name) do |last_module|
            body << "#{module_name} = {};"

            code[2].each do |part|
              k = part[0]
              v = part[1]
              case k
              when :identifier
                body                                      <<
                  "#{module_name}.#{k.value} = "          <<
                  replace(v) << ";"
              when :dstring
                body                                      <<
                  "#{module_name}[#{k.value}] = "         <<
                  replace(v)  << ";"
              when :class
                body << generate_class(part)
              end
            end

            if last_module
              body                                        <<
                "#{last_module}.#{module_name} = "        <<
                "#{module_name};"
            end
          end

          body
        end

        protected

        def current_module
          @modules.last
        end

        def in_module(module_name)
          @modules << module_name
          out = yield @modules[-2]
          @modules.pop
          out
        end

      end
    end
  end
end
