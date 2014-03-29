module Liquidscript
  module Scanner
    class Liquidscript < Base
      module Interpolations
        include Base::DSL

        define do
          context :istring do
            init { @buffer = [] }

            on('\\"') { |m| @buffer << m }
            on('"') do
              emit :istring, @buffer.join
              exit
            end

            on(%r{\#\{(.*?)\}}) do |_, b|
              emit :istring_begin, @buffer.join
              lex :main => b
              @buffer = []
            end

            on(:_) { |m| @buffer << m }
          end
        end
      end
    end
  end
end
