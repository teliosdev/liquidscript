module Liquidscript
  module Compiler
    class Base
      module Helpers

        # Normalizes an action for the hash passed to {#expect}.  If
        # a block is given, it returns that block.  If the argument is
        # a proc, it returns that proc.  If none of those conditions are
        # met, it returns the {Action}.
        #
        # @yield nothing.
        # @param act [Proc, nil] the proc to return, if it is a proc.
        # @return [Proc, Action]
        def action(act = nil)
          if block_given?
            Proc.new
          elsif act.is_a? Proc
            act
          else
            @action
          end
        end

        # Performs a loop while the yield returns true.  This
        # overwrites the core loop on purpose.
        #
        # @yieldreturn [Boolean] whether or not to continue looping.
        # @return [void]
        def loop
          result = true

          while result
            result = yield
          end
        end

        # Shift a token over.  The given types can be any types.  If
        # the next token's type doesn't match any of the types, then
        # it will raise an error.  In order to shift any token, use
        # the special type `:_`.
        #
        # @param types [Symbol] the token types to look for.
        # @return [#type] the token.
        def shift(*types)
          expect types => action.shift
        end

        # Shifts a token if its one of the given types; if it's not,
        # it returns the value of {#scanner_nil}.
        #
        # @param types [Symbol] the token types to look for.
        # @return [#type] the token.
        def maybe(*types)
          expect types => action.shift, :_ => action { scanner_nil }
        end

        # Checks to see if the next token is of any of the given
        # types.  Note that the special type `:_` does not work here.
        #
        # @param types [Symbol] the token types to match.
        # @return [Boolean] whether or not the next token's type
        #   matches any of the given types.
        def peek?(*types)
          types.any? { |type| peek.type == type }
        end

        # @overload collect_compiles(compile, *end_on)
        #   Calls the method `:compile_#{compile}` for every peeked
        #   token that isn't a part of `end_on`.  Once it encounters
        #   that, it returns the values of all of those calls.  If the
        #   last element of `end_on` is a Hash, it is merged with the
        #   default actions that this takes and passes it to `expect`.
        #
        #   @example
        #     def compile_if
        #       shift :if
        #       shift :lparen
        #       conditional = compile_expression
        #       shift :rparen
        #       shift :lbrack
        #       body = collect_compiles(:expression, :rbrack)
        #       [:if, conditional, body]
        #     end
        #   @param compile [Symbol] the method to call.
        #   @param end_on [Array<Symbol>] an array of symbols to end
        #     the loop.
        #   @return [Array<Object>]
        #
        # @overload collect_compiles(*end_on, &block)
        #    Calls the block for every peeked token that isn't in
        #    `end_on`.  Once it encounters a token that it, it returns
        #    the value of all of the block calls. If the
        #   last element of `end_on` is a Hash, it is merged with the
        #   default actions that this takes and passes it to `expect`.
        #
        #    @example
        #      collect_compiles(:test) { shift :_ }
        #
        #    @yieldreturn The value you want to be placed in the
        #      array.
        #    @param end_on [Array<Symbol>] an array of symbols to end
        #      the loop.
        #    @return [Array<Object>] the results of all of the block
        #      calls.
        def collect_compiles(*end_on)
          compiles = []

          if block_given?
            compile = Proc.new
          else
            compile = end_on.shift
          end

          block = Callable.new(self, compile)

          hash = if end_on.last.is_a? Hash
            end_on.pop.dup
          else
            {}
          end

          do_compile = action do
            compiles << block.call
          end

          hash.merge! end_on => action.end_loop,
                      :_     => do_compile

          loop do
            expect hash
          end

          compiles
        end

        # The meat and potatos of the compiler.  This maps actions to
        # tokens.  In its basic form, it is passed a hash, with the
        # keys being token types, and the values the corresponding
        # actions to take.  It can be passed individual types, from
        # which it'll assume the method name (normally,
        # `compile_<type>`); or, you can pass it a symbol key, which
        # is the last part of the method name (i.e., not including
        # `compile_`).  It will check the next token, and look for the
        # correct action; if the next token doesn't match any of the
        # given keys, it checks for the special type `:_` (which is
        # basically a catch-all), and if it still doesn't get it, it
        # raises an {UnexpectedError}.  From there, it calls the
        # corresponding block.
        #
        # If the block or method accepts one argument, it {#pop}s the
        # token, and passes it in as an argument.  If it accepts no
        # arguments, it doesn't.
        #
        # @example
        #   # If the next token has type `:test`, it will output
        #   # "hello!"  If the next token has any other type, it
        #   # raises an error.
        #   expect :test => action { puts "hello!" }
        # @example
        #   # If the next token has the type `:number`, it calls
        #   # the method `compile_number`; if the next token has
        #   # the type `:dstring`, it calls the method
        #   # `compile_string`.
        #   expect :number, :dstring => :string
        # @example
        #   # Just pops the comma token.
        #   expect :comma => action.shift
        # @example
        #   # When given a hash with one of the keys as an array, each
        #   # element of that array is treated as a token type, and
        #   # that token type is mapped to the value as an action.
        #   expect [:identifier, :dstring] => action.end_loop
        # @example
        #   # When given `:_` as an argument, it'll map the next token
        #   # to its corresponding compile function.
        #   expect :_
        #   # If the next token's type is `:identifier`, it will call
        #   # `compile_identifier`.
        # @param *args [Array<Symbol, Hash<Symbol, Object>>]
        # @raise [UnexpectedError] if the next token's type didn't
        #   match any of the given types, and the `:_` type wasn't
        #   given.
        # @return [Object] the result of the block/method call.
        def expect(*args)
          hash = normalize_arguments(args)

          block = hash.fetch(peek.type) do
            hash.fetch(:_)
          end

          out = if block.arity == 1
            block.call pop
          else
            block.call
          end

          out

        rescue KeyError
          raise UnexpectedError.new(hash.keys, peek, self)
        end

        protected

        def allowable
          @_allowable ||= begin
            self.class.allowable.to_a.inject({}) do |m, (k, v)|
              m.merge! k => Callable.new(self, v)
            end
          end
        end

        # Normalizes the arguments for {#expect}.  Turns all of the
        # values into {Callable}s, and everything that's not a hash
        # is merged into the hash.
        #
        # @param args [Array<Hash, Symbol>]
        # @return [Hash]
        def normalize_arguments(args)
          hash = if args.last.is_a? Hash
            args.pop.dup
          else
            {}
          end

          args.inject(hash) do |h, a|
            h.merge! a => if a == :_
              peek.type
            else
              a
            end
          end

          hash.inject({}) do |out, (key, value)|
            c = Callable.new(self, value)

            if key.is_a? Array
              key.each { |k| out[k] = c }
            else
              out[key] = c
            end

            out
          end
        end
      end
    end
  end
end
