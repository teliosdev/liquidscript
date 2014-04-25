module Liquidscript
  module Compiler
    class ICR < Base
      module Directives
        module ClassMethods

          def directives
            @_directives ||= {}
          end

          def define_directive(name, body)
            directives[name] = Base::Callable.new(nil, body, "")
          end

        end

        module InstanceMethods

          extend Forwardable

          def_delegators "self.class", :directives, :define_directive

          def handle_directive(directive)
            command, args = directive[:command], directive[:arguments]

            callable = directives.fetch(command)

            callable.bind = self
            callable.call(args)

          rescue KeyError
            raise UnknownDirectiveError.new(command)
          end

          def directive_allow(args)
            args.each do |a|
              top.context.allow(a.value.intern)
            end

            nil
          end

          def directive_cvar(*args)
            args.each do |a|
              top.context.set(a.value.intern, :class => true).parameter!
            end

            nil
          end

          def directive_strict
            code :sstring, "use strict"
          end

        end

        def self.included(receiver)
          receiver.extend         ClassMethods
          receiver.send :include, InstanceMethods

          InstanceMethods.instance_methods.each do |m|
            if m.to_s =~ /\A_?directive_([A-Za-z0-9]+)\z/
              receiver.define_directive($1, m)
            end
          end
        end

      end
    end
  end
end
