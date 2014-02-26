module Liquidscript

  class Error < ::StandardError; end

  class CompileError < Error; end
  class InvalidReferenceError < Error

    def initialize(name)
      super "No variable named #{name}"
    end

  end
end
