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
                 :while, :action, :try, :return,
                 :colon => :directive, :_ => :vexpression
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

        def compile_return
          shift :return
          code :return, compile_vexpression
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

        def compile_directive
          shift :colon
          shift :lbrack
          command = shift(:identifier).value
          old, @in_directive = @in_directive, true
          arguments = collect_compiles :rbrack do
            expect :lbrace     => action { _compile_block },
                   :identifier => action.shift,
                   :_          => :vexpression
          end

          directive = {
            :command => command,
            :arguments => arguments }


          out = if old
            directive
          else
            handle_directive(directive)
          end

          @in_directive = old
          out
        end

        def _compile_lparen_method
          ident = shift :identifier

          if peek?(:equal)
            shift(:equal)
            v = compile_vexpression
          else
            v = nil
          end

          if peek?(:comma, :rparen)
            _compile_lparen_method_final([ident, v])
          else
            out = value_expect(ref(ident))
            shift :rparen
            code :expression, out
          end
        end


        def _compile_lparen_method_final(ident = nil)
          components = [ident].compact
          _build_set
          set(ident[0]) if ident

          while peek?(:comma)
            components << _compile_lparen_argument
          end

          @set.pop

          shift :rparen
          compile_function_with_parameters(components)
        end

        def _compile_lparen_expression
          out = compile_vexpression
          shift :rparen
          code :expression, out
        end

        def _compile_lparen_argument
          shift(:comma)

          ident = shift(:identifier)
          set(ident)

          erange = action do |_|
            if top[:etc]
              raise CompileError,
                "A drain argument has already been specified!"
            end

            top[:etc] = ident
            :etc
          end

          value = expect :equal  => action { |_| compile_vexpression },
                         :erange => erange, :_ => action { nil }

          [ident, value]
        end

      end
    end
  end
end
