module Liquidscript

  class Error < ::StandardError; end

  class SyntaxError < Error; end
  class CompileError < Error;  end
  class GeneratorError < Error; end

  class UnexpectedEndError < CompileError; end
  class InvalidReferenceError < CompileError

    def initialize(name)
      super "No variable named #{name}"
    end
  end

  class UnknownDirectiveError < CompileError
    def initialize(directive)
      super "Unkown directive: #{directive}"
    end
  end

  class UnexpectedError < CompileError
    def initialize(expected, got)
      @expected = expected
      @got = got

      super build_error_message
    end

    private

    def build_error_message
      str = "Expected one of %{expected}, got %{type}"
      hash = {
        :expected => @expected.map { |e| e.to_s.upcase }.join(', ')
      }

      if @got.is_a? Symbol
        hash[:type] = @got.to_s.upcase
      else
        str << " (line %{line}, column %{column})"
        hash.merge! :type   => @got.type.to_s.upcase,
                    :line   => @got.line,
                    :column => @got.column
      end

      sprintf(str, hash)
    end
  end

  class InvalidCodeError < GeneratorError
    def initialize(code)
      super "Could not generate code for `#{code.to_s.upcase}`"
    end
  end

  class NoContextError < SyntaxError
    def initialize(context)
      super "Could not find context named #{context.inspect}"
    end
  end

end