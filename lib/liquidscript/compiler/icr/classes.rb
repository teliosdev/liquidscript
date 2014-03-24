module Liquidscript
  module Compiler
    class ICR
      module Classes

        def compile_class
          shift :class
          name = shift :identifier
          inherit = nil
          set name
          # Inheritance ftw!
          if peek?(:colon)
            shift :colon
            inherit = shift :identifier
            ref inherit
          end

          body = _compile_class_body(false)

          code :class, name, inherit, body
        end

        def compile_module
          m = shift :module
          if peek? :identifier
            name = shift :identifier
            set name
            body = _compile_class_body(true)

            code :module, name, body
          else
            value_expect _new_token(m, :identifier)
          end
        end

        def _new_token(old, type)
          Scanner::Token.new(type, old.type.to_s, old.line,
                             old.column)
        end

        def _compile_class_body(mod = false)
          shift :lbrace

          components = []

          compile_object = action do
            components << [
              _compile_class_body_key(mod),
              compile_vexpression
            ]
          end

          loop do
            expect :newline, :rbrace => action.end_loop,
            :comma         => action.shift,
            :module        => action { components << compile_module },
            :class         => action { components << compile_class  },
            [:identifier, :istring] => compile_object
          end

          components
        end

        def _compile_class_body_key(mod)
          item = shift :identifier, :istring

          item = compile_property(item) if item.type == :identifier &&
            peek?(:prop) && !mod

          shift :colon
          item
        end
      end
    end
  end
end
