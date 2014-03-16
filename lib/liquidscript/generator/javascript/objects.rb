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

          prop << "." << code[2]
        end

        def generate_class(code)
          body       = buffer
          class_name = code[1].value

          in_module(class_name) do |last_module|
            body.block 7 - @indent, <<-JS
              #{class_name} = #{class_name} || function #{class_name}() {
                if(this.initialize) {
                  this.initialize.apply(this, arguments);
                }
              }
            JS

            if code[2]
              body.block 8 - @indent, <<-JS
                #{class_name}.prototype.__proto__ = #{code[2].value};
              JS
            end

            code[3].each do |part|
              k, v = part
              case k.type
              when :identifier
                body.block 8 - @indent, <<-JS
                  #{class_name}.prototype.#{k.value} = #{replace(v)};
                JS
              when :istring
                body.block 8 - @indent, <<-JS
                  #{class_name}.prototype[#{k.value}] = #{replace(v)};
                JS
              when :property
                if k[1].value != "this"
                  raise InvalidCodeError.new(k[1].value)
                end

                body.block 8 - @indent, <<-JS
                  #{class_name}.#{k[2]} = #{replace(v)};
                JS
              when :class
                body << generate_class(part)
              when :module
                body << generate_module(part)
              end
            end

            if last_module
              body.block 7, <<-JS
                #{last_module}.#{class_name} = #{class_name}
              JS
            end

          end

          body
        end

        def generate_module(code)
          body = buffer
          module_name = code[1].value

          in_module(module_name) do |last_module|
            body << "#{module_name} = #{module_name} || {};"

            code[2].each do |part|
              k, v = part
              to_match = if k.is_a? Symbol
                k
              else
                k.type
              end

              case to_match
              when :identifier
                body.block 7, <<-JS
                  #{module_name}.#{k.value} = #{replace(v)};
                JS
              when :istring
                body.block 7, <<-JS
                  #{module_name}["#{k.value}"] = #{replace(v)};
                JS
              when :class
                body << generate_class(part)
              when :module
                body << generate_module(part)
              end
            end

            if last_module
              body.block 7, <<-JS
                #{last_module}.#{module_name} = #{module_name}
              JS
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
