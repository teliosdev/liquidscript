module Liquidscript
  class Buffer

    def initialize(*args)
      @_buf = args
      @_cache = nil
    end

    def append(*a)
      @_cache = nil
      @_buf.push(*a)
    end

    alias_method :<<, :append
    alias_method :push, :append

    def to_s
      @_cache ||= begin
        @_buf.join ''
      end
    end

    def inspect
      to_s.inspect
    end

  end
end
