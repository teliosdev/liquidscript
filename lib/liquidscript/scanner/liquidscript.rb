module Liquidscript
  module Scanner
    class Liquidscript < Base

      include Base::DSL

      attr_reader :tokens

      define do
        default_context :main

        context :main do
          set :number, %r{
            -? [0-9][1-9]*     # the base of the number
            (\.[0-9]+)?        # decmial portion, if needed
            ([eE][+-]?[0-9]+)? # scientific notation
          }x

          set :string, %r{
            '
            [A-Za-z0-9_$\-]+
            '?
          }x

          set :unops, %w(
            !
            ++
            --
            ~
            new
            return
            typeof
          )

          set :binops, %w(
            + - * / ^
            << >> >>>
            == ===
            != !==
            > >=
            < <=
            && ||
            & |
            instanceof
            or and
          )

          set :keywords, %w(
            undefined
            null
            true
            false
          )

          set :identifier, %r{[A-Za-z_$][A-Za-z0-9_$]*}

          on("class")     {     emit :class         }
          on("module")    {     emit :module        }
          on("if")        {     emit :if            }
          on("unless")    {     emit :unless        }
          on("elsif")     {     emit :elsif         }
          on("else")      {     emit :else          }
          on(:number)     { |m| emit :number,  m    }
          on(:string)     { |m| emit :sstring, m    }
          on(:keywords)   { |m| emit :keyword, m    }
          on("->")        {     emit :arrow         }
          on("=")         {     emit :equal         }
          on("{")         {     emit :lbrack        }
          on("(")         {     emit :lparen        }
          on("[")         {     emit :lbrace        }
          on("}")         {     emit :rbrack        }
          on(")")         {     emit :rparen        }
          on("]")         {     emit :rbrace        }
          on(":")         {     emit :colon         }
          on(".")         {     emit :prop          }
          on(",")         {     emit :comma         }
          on("\n")        {     line!               }
          on(:binops)     { |m| emit :binop,   m    }
          on(:unops)      { |m| emit :unop,    m    }
          on(:identifier) { |m| emit :identifier, m }

          on(%r{"} => :istring)
          on(%r{<<([A-Z]+)([^\n]*)\n}) do |_, s, e|
            @start = s
            emit :heredoc_ref, s
            lex :main => e unless e.empty?
            lex :heredoc
          end
          on(%r{<<-([A-Z]+)([^\n]*)\n}) do |_, s, e|
            @start = s
            emit :iheredoc_ref, s
            lex :main => e
            lex :iheredoc
          end

          on(%r{#.*?\n}) { }
          on(%r{\s})     { }
          on(:_)         { |m| error }
        end

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

        context :heredoc do
          init { @buffer = [] }

          on(%r{\s*([A-Z]+)\s*\n}) do |_, s|
            if @start == s
              emit :heredoc, @buffer.join
              @start = nil
              exit
            else
              @buffer << _
            end
          end

          on(:_) { |m| @buffer << m }
        end

        context :iheredoc do
          init { @buffer = [] }

          on(%r{\s*([A-Z]+)\s*\n}) do |_, s|
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

        context :regex do
          init { @buffer = [] }

          on(%r{\\/}) { |m| @buffer << m }
          on(%r{/})   { emit :regex, @buffer.join; exit }
          on(:_)      { |m| @buffer << m }
        end

        context :block_regex do
          init { @buffer = [] }

          on(%r{///})    { emit :bregex, @buffer.join; exit }
          on(%r{#.*?\n}) { }
          on("\n")       { }
          on(:_)         { |m| @buffer << m }
        end
      end

      def initialize(*)
        @line = 1
        @cstart = 0
        super
      end

      def line!
        @line += 1
        @cstart = @scanner.pos
      end

      def line
        @line
      end

      def column
        @scanner.pos - @cstart
      end
    end
  end
end
