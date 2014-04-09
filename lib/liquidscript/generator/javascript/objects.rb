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
          args.set_join! ', '

          call << "#{replace(code[1])}"

          code[2..-1].inject(args) do |b, arg|
            b << replace(arg)
          end

          call << "(" << args << ")"
        end

        def generate_property(code)
          prop = buffer

          case code[1].type
          when :variable
            prop << code[1].name
          else
            prop << replace(code[1])
          end

          prop << "." << code[2]
        end

        def generate_class(code)
          _context :name        => code[1].value,
                   :inherit     => code[2],
                   :parts       => code[3],
                   :inheritance => "%{name}.prototype.__proto__  = %{inherit};\n",
                   :identifier  => "%{name}.prototype.%{value} = %{replace};\n",
                   :istring     => "%{name}.prototype[\"%{value}\"] = %{replace};\n",
                   :property    => "%{name}.%{value} = %{replace};\n",
                   :head        => "%{name} = %{name} || function %{name}() {\n#{indent!}" <<
                                   "if(this.initialize) {\n#{indent!}this.initialize.apply(this, " +
                                   "arguments);\n#{unindent!}}\n#{unindent!}};\n"
        end

        def generate_module(code)
          _context :name       => code[1].value,
                   :parts      => code[2],
                   :head       => "%{name} = %{name} || {};\n",
                   :identifier => "%{name}.%{value} = %{replace};\n",
                   :istring    => "%{name}[\"%{value}\"] = %{replace};\n",
                   :property   => false
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

        def _context(options)
          body = buffer
          name = options[:name]
          opts = { :name => name }

          in_module(name) do |last_module|
            opts[:last] = last_module
            _build_header(body, options, opts)

            options[:parts].each do |part|
              _build_element(body, options, opts, part)
            end

            if last_module
              body << "#{last_module}.#{name} = #{name};\n"
            end
          end

          body
        end

        def _build_element(body, options, opts, part)
          k, v = part

          type = if k.is_a? Symbol then k else k.type end

          case type
          when :identifier, :istring
            opts[:value] = k.value
            opts[:replace] = replace(v)

            body << sprintf(options[k.type], opts)
          when :property
            opts[:value]   = k[2]
            opts[:replace] = replace(v)

            if k[1].value == "this" && options[k.type]
              body << sprintf(options[k.type], opts)
            else
              raise InvalidCodeError.new(k[1].value)
            end
          when :class
            body << generate_class(part)
          when :module
            body << generate_module(part)
          end
        end

        def _build_header(body, options, opts)
          body << sprintf(options[:head], opts)

          if options[:inherit]
            opts[:inherit] = options[:inherit].value
            body << sprintf(options[:inheritance], opts)
          end
        end

      end
    end
  end
end
