%%{

  machine lexer;

  variable data @data;
  variable p    @p;
  variable pe   @pe;
  variable eof  @eof;
  access @;

  number_integer = '-'? [0-9][1-9]*;
  number_frac = '.' [0-9]+;
  number_e = ('e' | 'E') ('+' | '-' | '');
  number_exp = number_e [0-9]+;
  number = number_integer number_frac? number_exp?;

  string_double = '"' ( any -- '"' | '\\"' )* '"';
  identifier = [A-Za-z_$][A-Za-z0-9_$]*;
  string_single = "'" [A-Za-z0-9_$\-]+;
  keywords = 'undefined' | 'null' | 'true' | 'false';
  unops = '!' | '++' | '--' | '~' | 'new' | 'return' |
    'typeof';
  binops = '+' | '-' | '*' | '/' | '&' | '|' | '^' | '<<' | '>>' |
    '>>>' | '==' | '!=' | '===' | '!==' | '>' | '>=' | '<' | '<=' |
    '&&' | '||' | 'instanceof' | 'or' | 'and';

  main := |*
    number        => { emit :number      };
    string_double => { emit :dstring     };
    string_single => { emit :sstring     };
    'class'       => { emit :class       };
    'module'      => { emit :module      };
    'if'          => { emit :if          };
    'unless'      => { emit :unless      };
    'elsif'       => { emit :elsif       };
    'else'        => { emit :else        };
    unops         => { emit :unop        };
    binops        => { emit :binop       };
    keywords      => { emit :keyword     };
    identifier    => { emit :identifier  };
    '->'          => { emit :arrow       };
    '='           => { emit :equal       };
    '{'           => { emit :lbrack      };
    '('           => { emit :lparen      };
    '['           => { emit :lbrace      };
    '}'           => { emit :rbrack      };
    ')'           => { emit :rparen      };
    ']'           => { emit :rbrace      };
    ':'           => { emit :colon       };
    '.'           => { emit :prop        };
    ','           => { emit :comma       };
    '\n'          => { line.call         };
    space         => {                   };
    any           => { error             };
  *|;
}%%

module Liquidscript
  class Scanner

    # A lexer, built from ragel.
    #
    # @private
    class Lexer

      attr_reader :tokens

      def initialize
        %% write data;
        # %% # fix
        @tokens = []
        clean!
      end

      def clean!
        @p = nil
        @pe = nil
        @te = nil
        @ts = nil
        @act = nil
        @eof = nil
        @top = nil
        @line = { :start => 0, :num => 0 }
        @data = nil
        @stack = nil
      end

      def emit(type)
        @tokens << Token.new(type, @data[@ts..(@te - 1)],
          @line[:num], @ts - @line[:start])
      end

      def error
        raise SyntaxError, "Unexpected #{@data[@ts..(@te-1)].pack('c*')}"
      end

      def perform(data)
        @data = data.unpack("c*") if data.is_a? String
        @eof = data.length

        @tokens = []

        line = proc do
          @line[:start] = @ts
          @line[:num] += 1
          emit :newline
        end

        %% write init;
        %% write exec;

        clean!

        @tokens
      end
    end
  end
end
