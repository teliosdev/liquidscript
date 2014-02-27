module Liquidscript
  module ICR
    class Sexp

      def initialize(compiler)
        @compiler = compiler
        @depth = 0
      end

      def output
        out(@compiler.top).strip
      end

      private

      def out(v)
        if v.is_a?(Representable) || v.is_a?(Array)
          @depth += 1
          body = ["\n", " " * @depth, "(",
            v.to_a.map {|d| out d }.join(' '),
            ")"].join
          @depth -= 1
          body
        else
          body = v.to_s.gsub(/\"/, "\\\"")

          if body.include? " "
            "\"#{body}\""
          else
            body
          end
        end
      end

    end
  end
end
