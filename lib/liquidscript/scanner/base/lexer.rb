module Liquidscript
  module Scanner
    class Base
      module Lexer

        def perform_with_context(context, scanner = @scanner)
          key, value = context.find_matcher(scanner)

          if value.nil? && scanner.rest?
            error scanner, context
          end

          normalize_action key, value, scanner if scanner.rest?
        end

        def lex(*args)
          args.flatten!
          to_lex = args.pop

          context, body = if to_lex.is_a? Hash
            to_lex.to_a.first
          else
            [to_lex, nil]
          end

          scanner = if body
            StringScanner.new(body)
          else
            @scanner
          end
          out = []

          context = find_context(context)
          instance_exec(*args, &context.init)

          while scanner.rest? && out.last != EXIT
            out << perform_with_context(context, scanner)
          end

          out
        end

        def error(scanner = @scanner, context = @context)
          raise SyntaxError, "Unexpected " +
            "#{scanner.matched}#{scanner.peek(2)}".inspect +
            " (line: #{line}, column: #{column})"
        end

        private

        def find_context(name)
          context = contexts.dup.keep_if { |c|
            c.name == name
          }.to_a.first

          if context.nil?
            raise NoContextError.new(name)
          end

          context
        end

        def exit
          EXIT
        end

        def normalize_action(key, value, scanner)
          body = scanner.scan(key)

          case value
          when Proc
            instance_exec(*body.match(key), &value)
          when Symbol
            lex(*body.match(key), value)
          when EXIT
            EXIT
          end
        end

      end
    end
  end
end
