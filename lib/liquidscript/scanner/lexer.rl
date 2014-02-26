%%{

  machine lexer;

  number_integer = '-'? [0-9][1-9]*;
  number_frac = '.' [0-9]+;
  number_e = ('e' | 'E') ('+' | '-' | '');
  number_exp = number_e [0-9]+;
  number = number_integer number_frac? number_exp?;

  string_double = '"' ( any -- '"' | '\\"' )* '"';
  string_single = "'" ( any -- [' ])+;

  identifier = [A-Za-z_$][A-Za-z0-9_$]*;

  main := |*
    number => { emit.(:number) };
    string_double => { emit.(:dstring) };
    string_single => { emit.(:sstring) };
    identifier => { emit.(:identifier) };
    '=' => { emit.(:equal) };
    '{' => { emit.(:lbrack) };
    '}' => { emit.(:rbrack) };
    space => {};
    any => { error.() };
  *|;
}%%

module Liquidscript
  class Scanner

    class SyntaxError < StandardError; end
    class Lexer

      attr_reader :tokens

      def initialize
        %% write data;
        # %% # fix
        @tokens = []
      end

      def emit(type, data)
        @tokens << Token.new(type, data)
      end

      def perform(data)
        data = data.unpack("c*") if data.is_a? String
        eof = data.length

        @tokens = []

        %% write init;

        emit = lambda do |type|
          self.emit(type, data[ts..(te - 1)])
        end

        error = lambda do
          raise SyntaxError, "Unexpected #{data[ts..(te-1)].pack('c*')}"
        end

        %% write exec;

        @tokens
      end
    end
  end
end
