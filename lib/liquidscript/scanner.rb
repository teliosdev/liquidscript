require "liquidscript/scanner/token"
require "liquidscript/scanner/lexer"

module Liquidscript

  # @todo Stream scanning.
  # um...
  class Scanner

    include Enumerable

    def initialize(source)
      @tokenizer = Lexer.new
      @source = source
    end

    def each
      e = buffer.each

      if block_given?
        e.each(&Proc.new)
      else
        e
      end
    end

    def inspect
      "#<#{self.class.to_s}:#{'0x%08x' % self.object_id}>"
    end

    private

    def buffer
      @_parts ||= begin
        @tokenizer.perform(@source)
      end
    end

  end
end
