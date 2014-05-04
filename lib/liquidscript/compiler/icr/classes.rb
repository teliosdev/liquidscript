module Liquidscript
  module Compiler
    class ICR
      module Classes

        def compile_class
          delegate_if_class do
            shift :class
            name    = shift :identifier
            inherit = nil
            existed = check(name)
            set(name)
            # Inheritance ftw!
            if peek?(:colon)
              shift :colon
              inherit = shift :identifier
              inherit = ref(inherit)
            end

            @classes[name.value] =
              expressions = Liquidscript::ICR::Set.new
            expressions.context =
              Liquidscript::ICR::Context.new.tap(&:class!)
            expressions.parent = if inherit
              @classes[inherit.name.to_s].tap { |t| t.parent = top }
            else
              top
            end

            @set << expressions
            body = _compile_class_body(false)
            expressions.context.force_defined!
            out  = code(:class, name, inherit, body)
            @set.pop
            out[:existed] = existed
            out
          end
        end

        def compile_module
          m = shift :module
          if peek? :identifier
            name    = shift :identifier
            existed = check(name)
            set(name)
            body    = _compile_class_body(true)

            out           = code :module, name, body
            out[:existed] = existed
            out
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

          if item.type == :identifier && !mod
            set(item)
          end

          shift :colon
          item
        end

        def delegate_if_class
          if top.context.class?
            top.context.delegate(&Proc.new)
          else
            yield
          end
        end
      end
    end
  end
end
