module Liquidscript
  module Compiler
    class ICR < Base
      module Expressions

        # Compiles an expression.  This is primarily used in a general
        # context, such that anything can be returned.
        #
        # @return [ICR::Code]
        def compile_expression
          expect :if, :unless, :class, :module, :loop, :for,
                 :while, :action, :try, :_ => :vexpression
        end

        # Compiles an expression that returns a value.
        #
        # @return [ICR::Code]
        def compile_vexpression
          out = expect :number,     :identifier,
                       :istring,    :lparen,
                       :sstring,    :operator,
                       :keyword,
                       :regex,
                       :newline,
                       :istring_begin,
                       :iheredoc_begin,
                       :plus, :minus,
                       :lbrace   => :object,
                       :lbrack   => :array,
                       :arrow    => :function,
                       [
                        :preunop, :unop
                       ]         => :unop,
                       [
                        :heredoc_ref, :iheredoc_ref
                       ]         => :href,
                       [
                        :heredoc, :iheredoc
                       ]         => :heredoc

          value_expect(out)
        end

        def compile_minus
          shift :minus

          code :neg, compile_vexpression
        end

        def compile_plus
          shift :plus

          code :pos, compile_vexpression
        end

        def compile_binop(left)
          code :binop, shift(:binop, :minus, :plus), left,
            compile_vexpression
        end

        def compile_unop
          code :unop, shift(:unop, :preunop), compile_vexpression
        end

        # Handles an assignment of the form `identifier = expression`,
        # with the argument being the identifier, and the position of
        # the compiler being after it.
        #
        # @return [ICR::Code]
        def compile_assignment(identifier)
          shift :equal

          if identifier.type == :identifier
            variable = set(identifier)
            value    = compile_vexpression
            variable.value = value
          else
            value    = compile_vexpression
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

          if peek?(:identifier)
            _compile_lparen_method
          elsif peek?(:rparen)
            _compile_lparen_method_final
          else
            _compile_lparen_expression
          end
        end

        def _compile_lparen_method
          ident = shift :identifier

          if peek?(:comma, :rparen)
            _compile_lparen_method_final(ident)
          else
            value_expect(ident)
          end
        end

        def _compile_lparen_method_final(ident = nil)
          components = [ident].compact

          while peek?(:comma) do
            shift(:comma)
            components << shift(:identifier)
          end

          shift :rparen
          compile_function_with_parameters(components)
        end

        def _compile_lparen_expression
          out = compile_vexpression
          shift :rparen
          code :expression, out
        end

      end
    end
  end
end
