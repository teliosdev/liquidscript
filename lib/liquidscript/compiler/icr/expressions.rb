module Liquidscript
  module Compiler
    class ICR < Base
      module Expressions

        # Compiles an expression.  This is primarily used in a general
        # context, such that anything can be returned.
        #
        # @return [ICR::Code]
        def compile_expression
          expect :number,     :identifier,
                 :dstring,    :lparen,
                 :sstring,
                 :lbrack   => :object,
                 :arrow    => :function
        end

        # Handles an assignment of the form `identifier = expression`,
        # with the argument being the identifier, and the position of
        # the compiler being after it.
        #
        # @return [ICR::Code]
        def compile_assignment(identifier)
          shift :equal
          value    = compile_expression
          name     = identifier.value.to_sym
          variable = top.context.set(name)

          variable.value = value

          code :set, variable, value
        end

        # We don't know, at this point, whether this is a function
        # declaration, or an expression; if it's a function declaration,
        # the contents of the lparen can only be commas and identifiers;
        # if it's an expression, it can have anything but commas in it.
        #
        # @return [ICR::Code]
        def compile_lparen
          shift :lparen
          maybe_func = 1
          components = []

          unless peek?(:identifier, :rparen)
            maybe_func = 0
          end

          expression = action do
            maybe_func = 0
            components << compile_expression
          end

          loop do
          case maybe_func
          when 0
            expect :rparen => action.end_loop,
              :_           => expression
          when 1
            expect :rparen => action.end_loop,
              :comma       => action { maybe_func = 2 },
              :identifier  => action { |i| components << i },
              :_           => expression
          when 2
            expect :rparen => action.end_loop,
              :comma       => action.shift,
              :identifier  => action { |i| components << i }
          end
          end

          func_decl = (maybe_func == 1 && peek?(:arrow)) ||
            (maybe_func == 2)

          if func_decl
            compile_function_with_components(components)
          else
            code :expression, components
          end
        end

      end
    end
  end
end
