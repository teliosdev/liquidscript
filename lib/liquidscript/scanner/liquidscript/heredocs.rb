module Liquidscript
  module Scanner
    class Liquidscript < Base
      module Heredocs
        include Base::DSL

        define do
          context :heredoc do
            init { @buffer = [] }

            on(%r{\n\s*([A-Z]+)\s*\n}) do |_, s|
              if @start == s
                emit :heredoc, @buffer.join
                exit
              else
                @buffer << _
              end
            end

            on(:_) { |m| @buffer << m }
          end

          context :iheredoc do
            init { @buffer = [] }

            on(%r{\n\s*([A-Z]+)\s*\n}) do |_, s|
              if @start == s
                emit :iheredoc, @buffer.join
                @start = nil
                exit
              else
                @buffer << _
              end
            end

            on(%r{\#\{(.*?)\}}) do |_, b|
              emit :iheredoc_begin, @buffer.join
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
