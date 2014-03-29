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

          def contexts
            @_contexts ||= Set.new
          end

          attr_accessor :default

        end

        def self.included(base)
          base.extend ClassMethods
        end
      end
    end
  end
end
