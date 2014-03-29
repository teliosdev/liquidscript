require 'set'

module Liquidscript
  module Scanner
    class Base
      class Builder

        EMPTY_VALUE = Object.new

        attr_reader :contexts

        def default_context(value = EMPTY_VALUE)
          if value.equal? EMPTY_VALUE
            @default_context
          else
            @default_context = value
          end
        end

        def contexts
          @contexts ||= Set.new
        end

        def context(name)
          case name
          when Symbol
            context = Context.new(name)
            context.instance_exec(&Proc.new)
            contexts << context
          when Module
            name.contexts.each do |context|
              contexts << context
            end
          end
        end

        def reset!
          @default_context = nil
          @contexts = nil
          self
        end
      end
    end
  end
end
