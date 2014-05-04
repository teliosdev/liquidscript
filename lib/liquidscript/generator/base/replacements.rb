require 'pp'

module Liquidscript
  module Generator
    class Base
      module Replacements

        # Replace a code with a string.  This uses the replacement
        # definitions that are a part of the class.
        #
        # @param code [ICR::Code, #type]
        # @param context [Hash]
        def replace(code, options = {})
          method_name = :"generate_#{code.type}"

          if method(method_name).arity.abs == 1
            send(method_name, code)
          else
            send(method_name, code, options)
          end

        rescue NoMethodError => e
          if e.name == method_name
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
