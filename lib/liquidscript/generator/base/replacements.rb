module Liquidscript
  module Generator
    class Base
      module Replacements

        # Replace a code with a string.  This uses the replacement
        # definitions that are a part of the class.
        #
        # @param code [ICR::Code, #type]
        # @param context [Hash]
        def replace(code, context = {})
          send(:"generate_#{code.type}",
            code)

        rescue NoMethodError => e
          if e.name == :"_generate_code_#{code.type}"
            raise InvalidCodeError.new(code.type)
          else
            raise
          end
        end

        # Access to the replacements method on the class.
        #
        # @see [ClassMethods#replacements]
        # @return [Hash]
        def replacements
          self.class.replacements
        end
      end
    end
  end
end
