module Liquidscript
  module Compiler
    class Base

      # Responds to all methods with `nil`.
      class Blank < BasicObject

        # Respond to all methods, with `nil`.
        #
        # @return [nil]
        def method_missing(*_, &block)
          nil
        end

        # Tells Ruby that we respond to all methods.
        #
        # @return [true]
        def respond_to_missing?(_, __)
          true
        end
      end
    end
  end
end
