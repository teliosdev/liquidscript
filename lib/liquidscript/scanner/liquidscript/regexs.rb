module Liquidscript
  module Scanner
    class Liquidscript < Base
      module Regexs
        include Base::DSL

        define do
          context :block_regex do
            init { @buffer = [] }

            on(%r{///([a-z]*)}) do |_, m|
              emit :regex, [@buffer.join, m]
              exit
            end
            on(%r{#.*?\n}) { }
            on("\n")       { }
            on(:_)         { |m| @buffer << m }
          end
        end
      end
    end
  end
end
