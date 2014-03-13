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
            + - * / & | ^
            << >> >>>
            == ===
            != !==
            > >=
            < <=
            && ||
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
          on(:unops)      { |m| emit :unop,    m    }
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
          on("\n")        {     line!; emit :newline}
          on(:binops)     { |m| emit :binop,   m    }
          on(:identifier) { |m| emit :identifier, m }

          on(/\"/ => :istring)
          on(/[\s]/) { }
          on(:_) { error }
        end

        context :istring do
          init do
            @buffer = []
          end

          on(/\\"/) { |m| @buffer << m }
          on(/"/) do
            emit :istring, @buffer.join
            exit
          end

          on(/\#\{(.*?)\}/) do |_, b|
            emit :istring_begin, @buffer.join
            lex :main => b
            @buffer = []
          end

          on(:_) { |m| @buffer << m }
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
