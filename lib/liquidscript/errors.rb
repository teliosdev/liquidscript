module Liquidscript

  class Error < ::StandardError; end

  class SyntaxError < Error; end
  class CompileError < Error;  end
  class GeneratorError < Error; end

  class UnexpectedEndError < CompileError; end
  class DirectiveError < CompileError; end

  class InvalidReferenceError < CompileError

    def initialize(name)
      super "No variable named #{name}"
    end
  end


  class UnknownDirectiveError < DirectiveError
    def initialize(directive)
      super "Unkown directive: #{directive}"
    end
  end

  class UnexpectedError < CompileError
    def initialize(expected, got)
      @expected = expected
      @got      = got

      super build_error_message
    end

    private

    def build_error_message
      str = "Expected one of %{expected}, got %{type}(%{value}) "
      hash = {
        :expected => @expected.map { |e| ns(e) }.join(', ')
      }

      if @got.is_a? Symbol
        hash[:type]  = ns(@got)
        hash[:value] = ""
      else
        hash.merge! :type   => ns(@got.type),
                    :value  => @got.value
      end

      sprintf(str, hash)
    end

    def ns(sym)
      sym.to_s.upcase
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
