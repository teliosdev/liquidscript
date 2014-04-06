module Liquidscript
  module ICR

    class ::Array; def to_sexp; Sexp.new(self); end; end

    # @private
    class Sexp

      def initialize(compiler)
        @compiler = compiler
        @depth = 0
      end

      def output
        out(@compiler).strip
      end

      def to_s
        output
      end

      private

      def out(v)
        if v.is_a?(Representable) || v.is_a?(Array)
          @depth += 1
          body = ["\n", " " * @depth, "(",
            v.to_a.map {|d| out(d) }.compact.join(' '),
            ")"].join
          @depth -= 1
          body
        else
          body = v.to_s.gsub(/\"/, "\\\"")

          if body.match(/[\s]/)
            "\"#{body}\""
          elsif body.length == 0
            nil
          else
            body
          end
        end
      end

    end
  end
end
