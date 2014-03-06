module Liquidscript
  module Generator
    class Base
      module DSL
        module ClassMethods

          def to_generate(code, &block)
            define_method(:"generate_#{code}", &block)
            protected :"generate_#{code}"
          end
        end

        def self.included(base)
          base.extend ClassMethods
        end
      end
    end
  end
end
