module Liquidscript
  module Scanner
    class Liquidscript < Base
      module Main
        include Base::DSL

        define do
          context :main do
            set :number, %r{
              -? (
                (                     # hex notation
                  0x([0-9a-f]+)
                )
                  |
                (                     # decimal or octal notation
                 ([1-9][0-9]* | 0)    # the base of the number
                 (\.[0-9]+)?          # decmial portion, if needed
                 ([eE][+-]?[0-9]+)?   # scientific notation
                )
              )
            }x

            set :string, %r{
              '
              [A-Za-z0-9_$\-\/\.]+
              '?
            }x

            set :unops, %w(
              ++
              --
            )

            set :preunops, %w(
              !
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
              * / ^
              << >> >>>
              === ==
              !== !=
              >= >
              <= <
              && ||
              += -= /= *=
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

            action :heredoc do |_, s|
              emit :heredoc_ref, s
              @lexes << [:heredoc, s]
            end

            action :iheredoc do |_, s|
              emit :iheredoc_ref, s
              @lexes << [:iheredoc, s]
            end

            action :regex do |_, m, b|
              emit :regex, [m, b]
            end

            action :directive do |_, c, a|
              metadata[:directives] ||= []
              metadata[:directives].push :command => c,
                                         :args    => a
            end

            action :identifier do |m|
              emit :identifier, m.gsub(/\-[a-z]/) { |p| p[1].upcase }
            end

            set :identifier, %r{[A-Za-z_$]([A-Za-z0-9_$-]*[A-Za-z0-9_$])?}

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
            on(:actions)    { |m| emit :action,  m    }
            on(%r{<<([A-Z]+)}, :heredoc)
            on(%r{<<-([A-Z]+)}, :iheredoc)
            on(%r{/(.*?)/([a-z]*)}, :regex)
            on(%r{"} => :istring)
            on("///" => :block_regex)
            on(:binops)     { |m| emit :binop,    m   }
            on(:preunops)   { |m| emit :preunop,  m   }
            on(:unops)      { |m| emit :unop,     m   }
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
            on("-")         {     emit :minus         }
            on("+")         {     emit :plus          }
            on("\n")        {     line!               }
            on(:identifier, :identifier)
            on(%r{#! ([A-Za-z]+) ?(.*?)\n}, :directive)

            on(%r{#.*?\n}) { }
            on(%r{\s})     { }
            on(:_)         { |m| error }
          end
        end
      end
    end
  end
end
