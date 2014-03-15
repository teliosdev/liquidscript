module Liquidscript
  class Buffer

    def initialize(*args)
      @_buf   = args
      @_cache = nil
      @_join  = ''
    end

    def append(*a)
      @_cache = nil
      @_buf.push(*a)
      self
    end

    def block(indent, str)
      append str.gsub(/^[ \t]{#{indent*2}}/, '')
    end

    def set_join!(to)
      @_join = to
    end

    alias_method :<<, :append
    alias_method :push, :append

    def to_s
      @_cache ||= begin
        @_buf.join @_join
      end
    end

    def inspect
      to_s.inspect
    end

  end
end
