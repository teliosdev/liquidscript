module Liquidscript
  module Compiler
    class ICR < Base
      module Literals

        def compile_number
          #code :number, pop.value
          n = shift(:number)

          if peek?(:prop)
            shift(:prop)
            shift(:prop)
            n2 = shift(:number)

            code :range, n.value, n2.value
          else
            code :number, n.value
          end
        end

        def compile_action
          code :action, shift(:action)
        end

        def compile_while
          shift :while
          shift :lparen
          conditional = compile_vexpression
          shift :rparen
          body = _compile_block
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

          v = set(ident)
          body = _compile_block
          code :for_in, v, ref(obj), body
        end

        def _compile_for_seg(first)
          first = value_expect(first)
          shift :comma
          second = compile_vexpression
          shift :comma
          third = compile_vexpression
          shift :rparen

          body = _compile_block
          code :for_seg, first, second, third, body
        end

        def compile_identifier(identifier)
          if peek?(:equal)
            identifier
          else
            ref(identifier)
          end
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
          _compile_interop(:iheredoc, contents)

          top[:heredocs][top[:herenum]].body = contents
          top[:herenum] += 1
          nil
        end

        def compile_istring_begin
          start = shift :istring_begin
          contents = [start]
          _compile_interop(:istring, contents)

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
          key = shift :identifier, :istring
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

        private

        def _compile_interop(type, contents)
          loop do
            contents << compile_vexpression
            if peek?(:"#{type}_begin")
              contents << shift(:"#{type}_begin")
            else
              contents << shift(type)
              false
            end
          end
        end

      end
    end
  end
end
