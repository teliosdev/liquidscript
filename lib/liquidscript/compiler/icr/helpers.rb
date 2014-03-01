module Liquidscript
  module Compiler
    class ICR < Base
      module Helpers

        def ref(literal)
          top.context.get(literal.value.intern)
        end

        def code(type, *args)
          Liquidscript::ICR::Code.new type, *args
        end
      end
    end
  end
end
