module Liquidscript
  module Compiler
    class ICR < Base
      module Expressions

        # Compiles an expression.  This is primarily used in a general
        # context, such that anything can be returned.
        #
        # @return [ICR::Code]
        def compile_expression
          expect :if, :unless, :class, :module, :_ => :vexpression
        end

        # Compiles an expression that returns a value.
        #
        # @return [ICR::Code]
        def compile_vexpression
          out = expect :number,     :identifier,
                       :istring,    :lparen,
                       :sstring,    :operator,
                       :keyword,    :unop,
                       :newline,
                       :istring_begin,
                       :iheredoc_begin,
                       :lbrack   => :object,
                       :lbrace   => :array,
                       :arrow    => :function,
                       [
                        :heredoc_ref, :iheredoc_ref
                       ]         => :href,
                       [
                        :heredoc, :iheredoc
                       ]         => :heredoc

          if peek? :binop
            compile_binop(out)
          elsif peek? :prop
            compile_property(out)
          else
            out
          end
        end

        def compile_binop(left)
          code :binop, shift(:binop), left, compile_vexpression
        end

        def compile_unop
          code :unop, shift(:unop), compile_vexpression
        end

        # Handles an assignment of the form `identifier = expression`,
        # with the argument being the identifier, and the position of
        # the compiler being after it.
        #
        # @return [ICR::Code]
        def compile_assignment(identifier)
          shift :equal
          value    = compile_vexpression

          if identifier.type == :identifier
            variable = set(identifier)
            variable.value = value
          else
            variable = identifier
          end

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
            components << compile_vexpression
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
            compile_function_with_parameters(components)
          else
            code(:expression, components.map do |c|
              if c.is_a?(Scanner::Token)
               compile_identifier(c)
              else
                c
              end
            end)
          end
        end

        [:if, :elsif].each do |key|
          define_method(:"compile_#{key}") do
            shift key
            shift :lparen
            conditional = compile_vexpression
            shift :rparen
            shift :lbrack

            body = collect_compiles(:expression, :rbrack)

            if peek?(:elsif, :else)
              code key, conditional, body, expect(:elsif, :else)
            else
              code key, conditional, body
            end
          end
        end

        def compile_unless
          shift :unless
          shift :lparen
          conditional = compile_vexpression
          shift :rparen
          shift :lbrack

          body = collect_compiles(:expression, :rbrack)
          code :unless, conditional, body
        end

        def compile_else
          shift :else
          shift :lbrack

          body = collect_compiles(:expression, :rbrack)

          code :else, body
        end

      end
    end
  end
end
