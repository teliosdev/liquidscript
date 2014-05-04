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

          def handle_directive(directive)
            command, args = directive[:command], directive[:arguments]

            callable = directives.fetch(command)

            callable.bind = self
            callable.call(*args)

          rescue KeyError
            raise UnknownDirectiveError.new(command)
          end

          def directives
            @_directives ||= self.class.directives.dup
          end

          def define_directive(name, body)
            directives[name] = Base::Callable.new(nil, body, "")
          end

          def directive_allow(*args)
            args.each do |a|
              top.context.set(a.value.intern).hidden!
            end

            nil
          end

          def directive_cvar(*args)
            args.each do |a|
              top.context.set(a.value.intern, :class => true).hidden!
            end

            nil
          end

          def directive_include(file)
            file_name = file[1]
            path = include_paths.find do |part|
              File.file?(File.join(part, file_name))
            end

            raise LoadError,
              "cannot load such file -- #{file}" unless path

            full_path = File.join(path, file_name)
            f         = File.open(full_path)
            scanner   = Scanner::Liquidscript.new(f.read, full_path)
            compiler  = Compiler::ICR.new(scanner)
            compiler.top.parent = top
            compiler.top.context.delegate!
            compiler.compile
          end

          def directive_include_path(*paths)
            include_paths.push(*paths.map(&:value))
            nil
          end

          def directive_strict
            top.metadata[:strict] = true

            nil
          end

          private

          def include_paths
            @_include_paths ||= [
              ".",
              File.expand_path("../", @scanner.metadata[:file]),
              *ENV.fetch("LIQUID_PATHS", "").split(':')
            ]
          end

        end

        def self.included(receiver)
          receiver.extend         ClassMethods
          receiver.send :include, InstanceMethods

          InstanceMethods.instance_methods.each do |m|
            if m.to_s =~ /\A_?directive_([A-Za-z0-9\_]+)\z/
              receiver.define_directive($1.gsub(/\_[a-z]/) { |m| m[1].upcase }, m)
            end
          end
        end

      end
    end
  end
end
