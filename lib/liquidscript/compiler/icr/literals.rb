module Liquidscript
  module Compiler
    class ICR < Base
      module Literals

        def compile_number
          code :number, pop.value
        end

        def compile_while
          shift :while
          shift :lparen
          conditional = compile_vexpression
          shift :rparen
          shift :lbrace
          body = collect_compiles(:expression, :rbrace)
          code :while, conditional, body
        end

        def compile_for
          shift :for
          shift :lparen
          if peek?(:identifier)
            ident = shift :identifier
            if peek?(:identifier)
              _compile_for_in(ident)
            else
              _compile_for_seg(compile_identifier(ident))
            end
          else
            compile_for_seg compile_vexpression
          end
        end

        def _compile_for_in(ident)
          content = shift :identifier
          unless content.value == "in"
            raise CompileError, "Expected `in', got #{content.value}"
          end

          obj = shift :identifier
          shift :rparen
          shift :lbrace

          set ident
          body = collect_compiles(:expression, :rbrace)
          code :for_in, ident, ref(obj), body
        end

        def _compile_for_seg(first)
          shift :comma
          second = compile_vexpression
          shift :comma
          third = compile_vexpression
          shift :lbrace

          body = collect_compiles(:expression, :rbrace)
          code :for_seg, first, second, third, body
        end

        def compile_identifier(identifier)
          default = action do
            code :get, ref(identifier)
          end

          expect :equal  => action { compile_assignment(identifier) },
                 :prop   => action { compile_property(identifier)   },
                 :lparen => action { compile_call(identifier)       },
                 :_      => default
        end

        def compile_regex
          code :regex, shift(:regex)
        end

        def compile_href
          ref = shift :heredoc_ref, :iheredoc_ref
          heredoc = Heredoc.new(ref.value, ref.type == :iheredoc_ref)
          top[:heredocs] ||= []
          top[:herenum]  ||= 0
          top[:heredocs] << heredoc
          code :href, heredoc
        end

        def compile_heredoc
          h = shift(:heredoc, :iheredoc)

          top[:heredocs][top[:herenum]].body = [h]
          top[:herenum] += 1
          nil
        end

        def compile_iheredoc_begin
          start = shift :iheredoc_begin
          contents = [start]

          loop do
            contents << compile_vexpression
            contents << shift(:iheredoc)
            peek?(:istring_begin)
          end

          top[:heredocs][top[:herenum]].body = contents
          top[:herenum] += 1
          nil
        end

        def compile_istring_begin
          start = shift :istring_begin
          contents = [start]

          loop do
            contents << compile_vexpression
            contents << shift(:istring)
            peek?(:istring_begin)
          end


          code :interop, *contents
        end

        def compile_istring
          code :istring, shift(:istring).value
        end

        def compile_sstring
          code :sstring, shift(:sstring).value[1..-1]
        end

        def compile_operator
          code :operator, shift(:operator), compile_vexpression
        end

        def compile_keyword
          code :keyword, shift(:keyword)
        end

        def compile_object
          shift :lbrace

          objects = collect_compiles :rbrace,
            :comma => action.shift,
            :newline => action.shift do
            [compile_object_key, compile_vexpression]
          end

          code :object, objects
        end

        def compile_array
          shift :lbrack

          parts = collect_compiles(:vexpression, :rbrack,
            :comma => action.shift)

          code :array, parts
        end

        def compile_object_key
          key = shift :identifier, :dstring
          shift :colon

          key
        end

        def compile_function
          compile_function_with_parameters([])
        end

        def compile_newline
          if peek?(:newline)
            pop
            code :newline
          end
        end

        def compile_function_with_parameters(parameters)
          shift :arrow
          shift :lbrace

          expressions = Liquidscript::ICR::Set.new
          expressions.context = Liquidscript::ICR::Context.new
          expressions.context.parent = top.context
          expressions[:arguments] = parameters
          @set << expressions

          parameters.each do |parameter|
            set(parameter).parameter!
          end


          expression = action do
            expressions << compile_expression
          end

          loop do
            expect :rbrace => action.end_loop,
                   :_      => expression
          end

          code :function, @set.pop
        end

      end
    end
  end
end
