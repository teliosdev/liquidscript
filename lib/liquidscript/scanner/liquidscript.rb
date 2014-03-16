module Liquidscript
  module Scanner
    class Liquidscript < Base

      include Base::DSL

      attr_reader :tokens

      define do
        default_context :main

        context :main do
          set :number, %r{
            -? ([1-9][0-9]* | 0) # the base of the number
            (\.[0-9]+)?          # decmial portion, if needed
            ([eE][+-]?[0-9]+)?   # scientific notation
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
            throw
          )

          set :actions, %w(
            break
            continue
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
          on("for")       {     emit :for           }
          on("while")     {     emit :while         }
          on("try")       {     emit :try           }
          on("catch")     {     emit :catch         }
          on("finally")   {     emit :finally       }
          on(:number)     { |m| emit :number,  m    }
          on(:string)     { |m| emit :sstring, m    }
          on(:keywords)   { |m| emit :keyword, m    }
          on(:actions)    { |m| emit :action, m     }
          on("->")        {     emit :arrow         }
          on("=")         {     emit :equal         }
          on("{")         {     emit :lbrace        }
          on("(")         {     emit :lparen        }
          on("[")         {     emit :lbrack        }
          on("}")         {     emit :rbrace        }
          on(")")         {     emit :rparen        }
          on("]")         {     emit :rbrack        }
          on(":")         {     emit :colon         }
          on(".")         {     emit :prop          }
          on(",")         {     emit :comma         }
          on("\n")        {     line!               }
          on(%r{"} => :istring)
          on(%r{<<([A-Z]+)}) do |_, s|
            emit :heredoc_ref, s
            @lexes << [:heredoc, s]
          end
          on(%r{<<-([A-Z]+)}) do |_, s|
            emit :iheredoc_ref, s
            @lexes << [:iheredoc, s]
          end
          on(%r{/(.*?)/([a-z]*)}) { |_, m, b|
            emit :regex, [m, b]
          }
          on("///" => :block_regex)
          on(:binops)     { |m| emit :binop,   m    }
          on(:unops)      { |m| emit :unop,    m    }
          on(:identifier) { |m| emit :identifier, m }

          on(%r{#! ([A-Za-z]+) ?(.*?)\n}) do |_, c, a|
            metadata[:directives] ||= []
            metadata[:directives].push :command => c,
                                       :args    => a
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

      def initialize(*)
        @line = 1
        @cstart = 0
        @lexes = []
        super
      end

      def line!
        @line += 1
        @cstart = @scanner.pos
        while @lexes.any?
          type, @start = @lexes.shift

          lex type
        end
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
