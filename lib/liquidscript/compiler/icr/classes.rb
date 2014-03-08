module Liquidscript
  module Compiler
    class ICR
      module Classes

        def compile_class
          shift :class
          name = shift :identifier
          body = _compile_class_body

          set name
          code :class, name, body
        end

        def compile_module
          shift :module
          name = shift :identifier
          body = _compile_class_body(true)

          set name
          code :module, name, body
        end

        def _compile_class_body(mod = false)
          shift :lbrack

          components = []

          compile_object = action do
            components << [
              _compile_class_body_key(mod),
              compile_vexpression
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

        def _compile_class_body_key(mod)
          item = shift :identifier, :dstring

          item = compile_property(item) if item.type == :identifier &&
            peek?(:prop) && mod

          shift :colon
          item
        end
      end
    end
  end
end
