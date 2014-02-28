module Liquidscript

  class Error < ::StandardError; end

  class CompileError < Error; end
  class SyntaxError < Error; end

  class InvalidReferenceError < CompileError

    def initialize(name)
      super "No variable named #{name}"
    end
  end

  class UnexpectedError < CompileError
    def initialize(expected, got)
      super "Expected one of " +
        "#{expected.map(&:to_s).map(&:upcase).join(', ')}, " +
        "got #{got.to_s.upcase}"
    end
  end

  class UnexpectedEndError < CompileError; end
end
