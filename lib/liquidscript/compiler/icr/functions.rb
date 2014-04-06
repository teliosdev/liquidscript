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
          v = expect [:identifier, :class, :module] => property

          v
        end

        def compile_access(body)
          shift :lbrack
          key = compile_vexpression
          shift :rbrack

          v = code :access, body, key

          v
        end

        def compile_call(subject)
          shift :lparen

          if subject.type == :identifier
            ref(subject)
          end

          arguments = collect_compiles :expression, :rparen,
            :comma => action.shift

          call = code :call, subject, *arguments
          call
        end


        def compile_function_with_parameters(parameters)
          shift :arrow

          expressions = _build_set(parameters)

          if peek?(:lbrace)
            shift :lbrace
            collect_compiles(:rbrace) do
              expressions << compile_expression
            end
          else
            expressions << compile_expression
          end

          code :function, @set.pop
        end

        private

        def _build_set(parameters)
          expressions = Liquidscript::ICR::Set.new
          expressions.context = Liquidscript::ICR::Context.new
          expressions.context.parent = top.context
          expressions[:arguments] = parameters
          @set << expressions

          parameters.each do |parameter|
            set(parameter).parameter!
          end

          expressions
        end
      end
    end
  end
end
