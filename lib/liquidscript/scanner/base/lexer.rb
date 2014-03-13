module Liquidscript
  module Scanner
    class Base
      module Lexer

        def perform_with_context(context, scanner = @scanner)
          key, value = context.find_matcher(scanner)

          if value.nil? && scanner.rest?
            error scanner
          end

          normalize_action key, value, scanner if scanner.rest?
        end

        def lex(argument)
          context, body =
          if argument.is_a?(Hash)
            argument.to_a.first
          else
            argument
          end

          scanner = if body
            StringScanner.new(body)
          else
            @scanner
          end
          out = []

          context = find_context(context)
          instance_exec &context.init

          while scanner.rest? && out.last != EXIT
            out << perform_with_context(context, scanner)
          end

          out
        end

        def error(scanner = @scanner)
          raise SyntaxError, "Unexpected #{scanner.peek(2).inspect}" \
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
            lex value
          when EXIT
            EXIT
          end
        end

      end
    end
  end
end
