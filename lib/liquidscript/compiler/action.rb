module Liquidscript
  class Compiler
    class Action

      def nothing
        @_nothing ||= proc { true }
      end

      def shift
        @_shift ||= proc { |_| true }
      end

      def end_loop
        @_end_loop ||= proc { |_| false }
      end
    end
  end
end
