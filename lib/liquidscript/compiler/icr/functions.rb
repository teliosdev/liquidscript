module Liquidscript
  module Compiler
    class ICR < Base
      module Functions

        def compile_property(prop)
          shift :prop

          property = action do |ident|
            code :property, prop, (ident.value || ident.type)
          end

          # Just in case there is a property named 'class' or 'module'
          expect [:identifier, :class, :module] => property
        end

        def compile_access(body)
          shift :lbrack
          key = compile_vexpression
          shift :rbrack

          code :access, body, key
        end

        def compile_call(subject)
          shift :lparen

          if subject.type == :identifier
            ref(subject)
          end

          arguments = collect_compiles :expression, :rparen,
            :comma => action.shift

          code :call, subject, *arguments
        end


        def compile_function_with_parameters(parameters)
          shift :arrow

          expressions = _build_set(parameters)
          expressions.push(*_compile_block)

          code :function, @set.pop
        end

        private

        def _build_set(parameters = [])
          expressions = Liquidscript::ICR::Set.new
          expressions.context = Liquidscript::ICR::Context.new
          expressions.context.parent = top.context
          expressions[:arguments] = parameters
          @set << expressions

          parameters.each do |parameter|
            if parameter[1] == :etc
              set(parameter[0]).hidden!
            else
              set(parameter[0]).parameter!
            end
          end

          expressions
        end
      end
    end
  end
end
