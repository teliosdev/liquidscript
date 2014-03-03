module Liquidscript
  module Compiler
    class ICR
      module Classes

        def compile_class
          shift :class
          name = shift :identifier

          body = _compile_class_body

          code :class, name, body
        end

        def compile_module
          shift :module
          name = shift :identifier

          body = _compile_class_body

          code :module, name, body
        end

        def _compile_class_body
          shift :lbrack

          components = []

          compile_object = action do
            components << [
              _compile_class_body_key,
              compile_expression
            ]
          end

          loop do
            expect :rbrack => action.end_loop,
            :comma         => action.shift,
            :module        => action { components << compile_module },
            :class         => action { components << compile_class  },
            [:identifier, :dstring] => compile_object
          end

          components
        end

        def _compile_class_body_key
          item = shift :identifier, :dstring

          item = compile_property(item) if item.type == :identifier &&
            peek?(:prop)

          shift :colon
          item
        end
      end
    end
  end
end
