module Liquidscript
  module Compiler
    class Base

      # Used to construct blocks that are used with {#expect}.  It's
      # primarily syntaxic sugar, and DRYness.
      class Action

        # Returns a block that returns true, and takes no arguments.
        # This is for {#expect}, when you don't want the token to be
        # shifted, and you don't want the loop to end (if applicable).
        #
        # @return [Proc]
        def nothing
          @_nothing ||= proc { true }
        end

        # Returns a block that returns the first argument given to it.
        # This is for {#expect}, when you want to shift the token, and
        # you don't want the loop to end (if applicable).  Also used
        # internally for {Helpers#shift}.
        #
        # @return [Proc]
        def shift
          @_shift ||= proc { |_| _ }
        end

        # Returns a block that returns false, and takes one argument.
        # This is for {#expect}, when you want to shift the token, and
        # you want the loop to end (if applicable).
        #
        # @return [Proc]
        def end_loop
          @_end_loop ||= proc { |_| false }
        end
      end
    end
  end
end
