module Liquidscript
  module Scanner
    class Base
      module DSL

        module ClassMethods

          def define
            builder.instance_exec(&Proc.new)
            contexts.merge builder.contexts
            self.default = builder.default_context
            builder.reset!
          end

          def builder
            @_builder ||= Builder.new
          end

        end

        def self.included(base)
          base.extend ClassMethods
        end
      end
    end
  end
end
