
# line 1 "lib/liquidscript/scanner/lexer.rl"

# line 67 "lib/liquidscript/scanner/lexer.rl"


module Liquidscript
  class Scanner

    # A lexer, built from ragel.
    #
    # @private
    class Lexer

      attr_reader :tokens

      def initialize
        
# line 20 "lib/liquidscript/scanner/lexer.rb"
class << self
	attr_accessor :_lexer_actions
	private :_lexer_actions, :_lexer_actions=
end
self._lexer_actions = [
	0, 1, 0, 1, 1, 1, 2, 1, 
	18, 1, 19, 1, 20, 1, 21, 1, 
	22, 1, 23, 1, 24, 1, 25, 1, 
	26, 1, 27, 1, 28, 1, 29, 1, 
	30, 1, 31, 1, 32, 1, 33, 1, 
	34, 1, 35, 1, 36, 1, 37, 1, 
	38, 1, 39, 1, 40, 1, 41, 2, 
	2, 3, 2, 2, 4, 2, 2, 5, 
	2, 2, 6, 2, 2, 7, 2, 2, 
	8, 2, 2, 9, 2, 2, 10, 2, 
	2, 11, 2, 2, 12, 2, 2, 13, 
	2, 2, 14, 2, 2, 15, 2, 2, 
	16, 2, 2, 17
]

class << self
	attr_accessor :_lexer_key_offsets
	private :_lexer_key_offsets, :_lexer_key_offsets=
end
self._lexer_key_offsets = [
	0, 3, 7, 10, 13, 14, 17, 21, 
	24, 27, 30, 33, 35, 39, 41, 87, 
	88, 89, 92, 93, 96, 99, 102, 110, 
	111, 120, 121, 125, 130, 134, 136, 138, 
	140, 141, 150, 159, 168, 177, 186, 195, 
	204, 213, 223, 232, 241, 250, 259, 268, 
	278, 287, 296, 305, 314, 323, 332, 341, 
	350, 359, 368, 377, 386, 395, 405, 414, 
	423, 432, 441, 450, 459, 468, 477, 486, 
	496, 505, 514, 523, 532, 541, 550, 560, 
	569, 578, 587, 596, 605, 614, 623, 632, 
	641
]

class << self
	attr_accessor :_lexer_trans_keys
	private :_lexer_trans_keys, :_lexer_trans_keys=
end
self._lexer_trans_keys = [
	34, 35, 92, 34, 35, 92, 123, 34, 
	35, 92, 34, 92, 125, 125, 34, 35, 
	92, 34, 35, 92, 123, 34, 35, 92, 
	34, 92, 125, 34, 92, 125, 34, 92, 
	125, 48, 57, 43, 45, 48, 57, 48, 
	57, 10, 32, 33, 34, 36, 38, 39, 
	40, 41, 43, 44, 45, 46, 58, 60, 
	61, 62, 91, 93, 94, 95, 97, 99, 
	101, 102, 105, 109, 110, 111, 114, 116, 
	117, 123, 124, 125, 126, 9, 13, 42, 
	47, 48, 57, 65, 90, 98, 122, 61, 
	61, 34, 35, 92, 125, 34, 35, 92, 
	34, 92, 125, 34, 92, 125, 36, 95, 
	48, 57, 65, 90, 97, 122, 38, 36, 
	45, 95, 48, 57, 65, 90, 97, 122, 
	43, 45, 62, 48, 57, 46, 69, 101, 
	49, 57, 69, 101, 48, 57, 48, 57, 
	60, 61, 61, 62, 62, 36, 95, 110, 
	48, 57, 65, 90, 97, 122, 36, 95, 
	100, 48, 57, 65, 90, 97, 122, 36, 
	95, 108, 48, 57, 65, 90, 97, 122, 
	36, 95, 97, 48, 57, 65, 90, 98, 
	122, 36, 95, 115, 48, 57, 65, 90, 
	97, 122, 36, 95, 115, 48, 57, 65, 
	90, 97, 122, 36, 95, 108, 48, 57, 
	65, 90, 97, 122, 36, 95, 115, 48, 
	57, 65, 90, 97, 122, 36, 95, 101, 
	105, 48, 57, 65, 90, 97, 122, 36, 
	95, 102, 48, 57, 65, 90, 97, 122, 
	36, 95, 97, 48, 57, 65, 90, 98, 
	122, 36, 95, 108, 48, 57, 65, 90, 
	97, 122, 36, 95, 115, 48, 57, 65, 
	90, 97, 122, 36, 95, 101, 48, 57, 
	65, 90, 97, 122, 36, 95, 102, 110, 
	48, 57, 65, 90, 97, 122, 36, 95, 
	115, 48, 57, 65, 90, 97, 122, 36, 
	95, 116, 48, 57, 65, 90, 97, 122, 
	36, 95, 97, 48, 57, 65, 90, 98, 
	122, 36, 95, 110, 48, 57, 65, 90, 
	97, 122, 36, 95, 99, 48, 57, 65, 
	90, 97, 122, 36, 95, 101, 48, 57, 
	65, 90, 97, 122, 36, 95, 111, 48, 
	57, 65, 90, 97, 122, 36, 95, 102, 
	48, 57, 65, 90, 97, 122, 36, 95, 
	111, 48, 57, 65, 90, 97, 122, 36, 
	95, 100, 48, 57, 65, 90, 97, 122, 
	36, 95, 117, 48, 57, 65, 90, 97, 
	122, 36, 95, 108, 48, 57, 65, 90, 
	97, 122, 36, 95, 101, 48, 57, 65, 
	90, 97, 122, 36, 95, 101, 117, 48, 
	57, 65, 90, 97, 122, 36, 95, 119, 
	48, 57, 65, 90, 97, 122, 36, 95, 
	108, 48, 57, 65, 90, 97, 122, 36, 
	95, 108, 48, 57, 65, 90, 97, 122, 
	36, 95, 114, 48, 57, 65, 90, 97, 
	122, 36, 95, 101, 48, 57, 65, 90, 
	97, 122, 36, 95, 116, 48, 57, 65, 
	90, 97, 122, 36, 95, 117, 48, 57, 
	65, 90, 97, 122, 36, 95, 114, 48, 
	57, 65, 90, 97, 122, 36, 95, 110, 
	48, 57, 65, 90, 97, 122, 36, 95, 
	114, 121, 48, 57, 65, 90, 97, 122, 
	36, 95, 117, 48, 57, 65, 90, 97, 
	122, 36, 95, 112, 48, 57, 65, 90, 
	97, 122, 36, 95, 101, 48, 57, 65, 
	90, 97, 122, 36, 95, 111, 48, 57, 
	65, 90, 97, 122, 36, 95, 102, 48, 
	57, 65, 90, 97, 122, 36, 95, 110, 
	48, 57, 65, 90, 97, 122, 36, 95, 
	100, 108, 48, 57, 65, 90, 97, 122, 
	36, 95, 101, 48, 57, 65, 90, 97, 
	122, 36, 95, 102, 48, 57, 65, 90, 
	97, 122, 36, 95, 105, 48, 57, 65, 
	90, 97, 122, 36, 95, 110, 48, 57, 
	65, 90, 97, 122, 36, 95, 101, 48, 
	57, 65, 90, 97, 122, 36, 95, 100, 
	48, 57, 65, 90, 97, 122, 36, 95, 
	101, 48, 57, 65, 90, 97, 122, 36, 
	95, 115, 48, 57, 65, 90, 97, 122, 
	36, 95, 115, 48, 57, 65, 90, 97, 
	122, 124, 0
]

class << self
	attr_accessor :_lexer_single_lengths
	private :_lexer_single_lengths, :_lexer_single_lengths=
end
self._lexer_single_lengths = [
	3, 4, 3, 3, 1, 3, 4, 3, 
	3, 3, 3, 0, 2, 0, 36, 1, 
	1, 3, 1, 3, 3, 3, 2, 1, 
	3, 1, 2, 3, 2, 0, 0, 2, 
	1, 3, 3, 3, 3, 3, 3, 3, 
	3, 4, 3, 3, 3, 3, 3, 4, 
	3, 3, 3, 3, 3, 3, 3, 3, 
	3, 3, 3, 3, 3, 4, 3, 3, 
	3, 3, 3, 3, 3, 3, 3, 4, 
	3, 3, 3, 3, 3, 3, 4, 3, 
	3, 3, 3, 3, 3, 3, 3, 3, 
	1
]

class << self
	attr_accessor :_lexer_range_lengths
	private :_lexer_range_lengths, :_lexer_range_lengths=
end
self._lexer_range_lengths = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 1, 1, 1, 5, 0, 
	0, 0, 0, 0, 0, 0, 3, 0, 
	3, 0, 1, 1, 1, 1, 1, 0, 
	0, 3, 3, 3, 3, 3, 3, 3, 
	3, 3, 3, 3, 3, 3, 3, 3, 
	3, 3, 3, 3, 3, 3, 3, 3, 
	3, 3, 3, 3, 3, 3, 3, 3, 
	3, 3, 3, 3, 3, 3, 3, 3, 
	3, 3, 3, 3, 3, 3, 3, 3, 
	3, 3, 3, 3, 3, 3, 3, 3, 
	0
]

class << self
	attr_accessor :_lexer_index_offsets
	private :_lexer_index_offsets, :_lexer_index_offsets=
end
self._lexer_index_offsets = [
	0, 4, 9, 13, 17, 19, 23, 28, 
	32, 36, 40, 44, 46, 50, 52, 94, 
	96, 98, 102, 104, 108, 112, 116, 122, 
	124, 131, 133, 137, 142, 146, 148, 150, 
	153, 155, 162, 169, 176, 183, 190, 197, 
	204, 211, 219, 226, 233, 240, 247, 254, 
	262, 269, 276, 283, 290, 297, 304, 311, 
	318, 325, 332, 339, 346, 353, 361, 368, 
	375, 382, 389, 396, 403, 410, 417, 424, 
	432, 439, 446, 453, 460, 467, 474, 482, 
	489, 496, 503, 510, 517, 524, 531, 538, 
	545
]

class << self
	attr_accessor :_lexer_indicies
	private :_lexer_indicies, :_lexer_indicies=
end
self._lexer_indicies = [
	2, 3, 4, 1, 2, 3, 4, 5, 
	1, 6, 3, 4, 1, 7, 8, 1, 
	5, 10, 9, 11, 12, 13, 10, 11, 
	12, 13, 14, 10, 15, 12, 13, 10, 
	16, 17, 10, 14, 18, 17, 10, 14, 
	19, 8, 1, 5, 21, 20, 22, 22, 
	23, 20, 23, 20, 26, 25, 27, 28, 
	29, 30, 31, 32, 33, 35, 36, 37, 
	38, 40, 41, 42, 43, 44, 45, 34, 
	29, 46, 47, 48, 49, 50, 51, 52, 
	53, 54, 55, 56, 57, 58, 59, 60, 
	25, 34, 39, 29, 29, 24, 61, 0, 
	34, 62, 2, 3, 4, 1, 10, 9, 
	11, 12, 13, 10, 16, 17, 10, 14, 
	7, 8, 1, 5, 29, 29, 29, 29, 
	29, 0, 34, 62, 65, 65, 65, 65, 
	65, 65, 0, 60, 62, 60, 66, 39, 
	62, 68, 69, 69, 39, 67, 69, 69, 
	21, 67, 23, 67, 34, 62, 34, 70, 
	62, 34, 62, 29, 29, 72, 29, 29, 
	29, 71, 29, 29, 73, 29, 29, 29, 
	71, 29, 29, 74, 29, 29, 29, 71, 
	29, 29, 75, 29, 29, 29, 71, 29, 
	29, 76, 29, 29, 29, 71, 29, 29, 
	77, 29, 29, 29, 71, 29, 29, 78, 
	29, 29, 29, 71, 29, 29, 79, 29, 
	29, 29, 71, 29, 29, 80, 81, 29, 
	29, 29, 71, 29, 29, 82, 29, 29, 
	29, 71, 29, 29, 83, 29, 29, 29, 
	71, 29, 29, 84, 29, 29, 29, 71, 
	29, 29, 85, 29, 29, 29, 71, 29, 
	29, 86, 29, 29, 29, 71, 29, 29, 
	87, 88, 29, 29, 29, 71, 29, 29, 
	89, 29, 29, 29, 71, 29, 29, 90, 
	29, 29, 29, 71, 29, 29, 91, 29, 
	29, 29, 71, 29, 29, 92, 29, 29, 
	29, 71, 29, 29, 93, 29, 29, 29, 
	71, 29, 29, 94, 29, 29, 29, 71, 
	29, 29, 95, 29, 29, 29, 71, 29, 
	29, 73, 29, 29, 29, 71, 29, 29, 
	96, 29, 29, 29, 71, 29, 29, 97, 
	29, 29, 29, 71, 29, 29, 98, 29, 
	29, 29, 71, 29, 29, 99, 29, 29, 
	29, 71, 29, 29, 100, 29, 29, 29, 
	71, 29, 29, 101, 102, 29, 29, 29, 
	71, 29, 29, 103, 29, 29, 29, 71, 
	29, 29, 104, 29, 29, 29, 71, 29, 
	29, 86, 29, 29, 29, 71, 29, 29, 
	73, 29, 29, 29, 71, 29, 29, 105, 
	29, 29, 29, 71, 29, 29, 106, 29, 
	29, 29, 71, 29, 29, 107, 29, 29, 
	29, 71, 29, 29, 108, 29, 29, 29, 
	71, 29, 29, 103, 29, 29, 29, 71, 
	29, 29, 109, 110, 29, 29, 29, 71, 
	29, 29, 85, 29, 29, 29, 71, 29, 
	29, 111, 29, 29, 29, 71, 29, 29, 
	112, 29, 29, 29, 71, 29, 29, 113, 
	29, 29, 29, 71, 29, 29, 103, 29, 
	29, 29, 71, 29, 29, 114, 29, 29, 
	29, 71, 29, 29, 115, 116, 29, 29, 
	29, 71, 29, 29, 117, 29, 29, 29, 
	71, 29, 29, 118, 29, 29, 29, 71, 
	29, 29, 119, 29, 29, 29, 71, 29, 
	29, 120, 29, 29, 29, 71, 29, 29, 
	121, 29, 29, 29, 71, 29, 29, 86, 
	29, 29, 29, 71, 29, 29, 122, 29, 
	29, 29, 71, 29, 29, 123, 29, 29, 
	29, 71, 29, 29, 124, 29, 29, 29, 
	71, 34, 62, 0
]

class << self
	attr_accessor :_lexer_trans_targs
	private :_lexer_trans_targs, :_lexer_trans_targs=
end
self._lexer_trans_targs = [
	14, 0, 14, 1, 2, 3, 17, 18, 
	10, 4, 5, 14, 6, 7, 8, 19, 
	18, 9, 20, 21, 14, 28, 13, 29, 
	14, 14, 14, 15, 17, 22, 23, 24, 
	14, 14, 14, 25, 14, 26, 14, 27, 
	14, 30, 15, 31, 14, 14, 33, 35, 
	39, 43, 47, 56, 61, 65, 66, 71, 
	77, 14, 88, 14, 14, 16, 14, 14, 
	14, 24, 14, 14, 11, 12, 32, 14, 
	34, 22, 36, 37, 38, 22, 40, 41, 
	22, 42, 22, 44, 45, 46, 22, 22, 
	48, 49, 50, 51, 52, 53, 54, 55, 
	57, 58, 59, 60, 22, 62, 63, 22, 
	64, 67, 68, 69, 70, 72, 73, 74, 
	75, 76, 78, 79, 85, 80, 81, 82, 
	83, 84, 86, 87, 22
]

class << self
	attr_accessor :_lexer_trans_actions
	private :_lexer_trans_actions, :_lexer_trans_actions=
end
self._lexer_trans_actions = [
	53, 0, 7, 0, 0, 0, 58, 58, 
	0, 0, 0, 9, 0, 0, 0, 61, 
	61, 0, 61, 58, 51, 5, 0, 0, 
	39, 37, 35, 82, 97, 91, 0, 97, 
	19, 25, 13, 0, 33, 0, 31, 5, 
	29, 0, 94, 0, 21, 27, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 17, 0, 23, 11, 0, 47, 45, 
	43, 55, 15, 41, 0, 0, 0, 49, 
	0, 85, 0, 0, 0, 64, 0, 0, 
	79, 0, 76, 0, 0, 0, 88, 70, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 67, 0, 0, 82, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 73
]

class << self
	attr_accessor :_lexer_to_state_actions
	private :_lexer_to_state_actions, :_lexer_to_state_actions=
end
self._lexer_to_state_actions = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 1, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0
]

class << self
	attr_accessor :_lexer_from_state_actions
	private :_lexer_from_state_actions, :_lexer_from_state_actions=
end
self._lexer_from_state_actions = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 3, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0
]

class << self
	attr_accessor :_lexer_eof_trans
	private :_lexer_eof_trans, :_lexer_eof_trans=
end
self._lexer_eof_trans = [
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 21, 21, 21, 0, 1, 
	63, 1, 1, 64, 64, 65, 1, 63, 
	1, 63, 63, 68, 68, 68, 63, 63, 
	63, 72, 72, 72, 72, 72, 72, 72, 
	72, 72, 72, 72, 72, 72, 72, 72, 
	72, 72, 72, 72, 72, 72, 72, 72, 
	72, 72, 72, 72, 72, 72, 72, 72, 
	72, 72, 72, 72, 72, 72, 72, 72, 
	72, 72, 72, 72, 72, 72, 72, 72, 
	72, 72, 72, 72, 72, 72, 72, 72, 
	63
]

class << self
	attr_accessor :lexer_start
end
self.lexer_start = 14;
class << self
	attr_accessor :lexer_first_final
end
self.lexer_first_final = 14;
class << self
	attr_accessor :lexer_error
end
self.lexer_error = -1;

class << self
	attr_accessor :lexer_en_main
end
self.lexer_en_main = 14;


# line 81 "lib/liquidscript/scanner/lexer.rl"
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
        raise SyntaxError, "Unexpected #{@data[@ts..(@te-1)].pack('c*')} " \
          "(line: #{@line[:num]}, col: #{@ts - @line[:start]}) (#{@tokens.inspect})"
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

        
# line 445 "lib/liquidscript/scanner/lexer.rb"
begin
	    @p ||= 0
	   @pe ||=  @data.length
	 @cs = lexer_start
	 @ts = nil
	 @te = nil
	 @act = 0
end

# line 122 "lib/liquidscript/scanner/lexer.rl"
        
# line 457 "lib/liquidscript/scanner/lexer.rb"
begin
	_klen, _trans, _keys, _acts, _nacts = nil
	_goto_level = 0
	_resume = 10
	_eof_trans = 15
	_again = 20
	_test_eof = 30
	_out = 40
	while true
	_trigger_goto = false
	if _goto_level <= 0
	if     @p ==    @pe
		_goto_level = _test_eof
		next
	end
	end
	if _goto_level <= _resume
	_acts = _lexer_from_state_actions[ @cs]
	_nacts = _lexer_actions[_acts]
	_acts += 1
	while _nacts > 0
		_nacts -= 1
		_acts += 1
		case _lexer_actions[_acts - 1]
			when 1 then
# line 1 "NONE"
		begin
 @ts =     @p
		end
# line 487 "lib/liquidscript/scanner/lexer.rb"
		end # from state action switch
	end
	if _trigger_goto
		next
	end
	_keys = _lexer_key_offsets[ @cs]
	_trans = _lexer_index_offsets[ @cs]
	_klen = _lexer_single_lengths[ @cs]
	_break_match = false
	
	begin
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + _klen - 1

	     loop do
	        break if _upper < _lower
	        _mid = _lower + ( (_upper - _lower) >> 1 )

	        if  @data[    @p].ord < _lexer_trans_keys[_mid]
	           _upper = _mid - 1
	        elsif  @data[    @p].ord > _lexer_trans_keys[_mid]
	           _lower = _mid + 1
	        else
	           _trans += (_mid - _keys)
	           _break_match = true
	           break
	        end
	     end # loop
	     break if _break_match
	     _keys += _klen
	     _trans += _klen
	  end
	  _klen = _lexer_range_lengths[ @cs]
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + (_klen << 1) - 2
	     loop do
	        break if _upper < _lower
	        _mid = _lower + (((_upper-_lower) >> 1) & ~1)
	        if  @data[    @p].ord < _lexer_trans_keys[_mid]
	          _upper = _mid - 2
	        elsif  @data[    @p].ord > _lexer_trans_keys[_mid+1]
	          _lower = _mid + 2
	        else
	          _trans += ((_mid - _keys) >> 1)
	          _break_match = true
	          break
	        end
	     end # loop
	     break if _break_match
	     _trans += _klen
	  end
	end while false
	_trans = _lexer_indicies[_trans]
	end
	if _goto_level <= _eof_trans
	 @cs = _lexer_trans_targs[_trans]
	if _lexer_trans_actions[_trans] != 0
		_acts = _lexer_trans_actions[_trans]
		_nacts = _lexer_actions[_acts]
		_acts += 1
		while _nacts > 0
			_nacts -= 1
			_acts += 1
			case _lexer_actions[_acts - 1]
when 2 then
# line 1 "NONE"
		begin
 @te =     @p+1
		end
when 3 then
# line 39 "lib/liquidscript/scanner/lexer.rl"
		begin
 @act = 2;		end
when 4 then
# line 40 "lib/liquidscript/scanner/lexer.rl"
		begin
 @act = 3;		end
when 5 then
# line 41 "lib/liquidscript/scanner/lexer.rl"
		begin
 @act = 4;		end
when 6 then
# line 42 "lib/liquidscript/scanner/lexer.rl"
		begin
 @act = 5;		end
when 7 then
# line 43 "lib/liquidscript/scanner/lexer.rl"
		begin
 @act = 6;		end
when 8 then
# line 44 "lib/liquidscript/scanner/lexer.rl"
		begin
 @act = 7;		end
when 9 then
# line 45 "lib/liquidscript/scanner/lexer.rl"
		begin
 @act = 8;		end
when 10 then
# line 46 "lib/liquidscript/scanner/lexer.rl"
		begin
 @act = 9;		end
when 11 then
# line 47 "lib/liquidscript/scanner/lexer.rl"
		begin
 @act = 10;		end
when 12 then
# line 48 "lib/liquidscript/scanner/lexer.rl"
		begin
 @act = 11;		end
when 13 then
# line 49 "lib/liquidscript/scanner/lexer.rl"
		begin
 @act = 12;		end
when 14 then
# line 50 "lib/liquidscript/scanner/lexer.rl"
		begin
 @act = 13;		end
when 15 then
# line 51 "lib/liquidscript/scanner/lexer.rl"
		begin
 @act = 14;		end
when 16 then
# line 53 "lib/liquidscript/scanner/lexer.rl"
		begin
 @act = 16;		end
when 17 then
# line 65 "lib/liquidscript/scanner/lexer.rl"
		begin
 @act = 28;		end
when 18 then
# line 40 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p+1
 begin  emit :dstring      end
		end
when 19 then
# line 41 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p+1
 begin  emit :istring      end
		end
when 20 then
# line 48 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p+1
 begin  emit :unop         end
		end
when 21 then
# line 49 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p+1
 begin  emit :binop        end
		end
when 22 then
# line 52 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p+1
 begin  emit :arrow        end
		end
when 23 then
# line 54 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p+1
 begin  emit :lbrack       end
		end
when 24 then
# line 55 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p+1
 begin  emit :lparen       end
		end
when 25 then
# line 56 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p+1
 begin  emit :lbrace       end
		end
when 26 then
# line 57 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p+1
 begin  emit :rbrack       end
		end
when 27 then
# line 58 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p+1
 begin  emit :rparen       end
		end
when 28 then
# line 59 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p+1
 begin  emit :rbrace       end
		end
when 29 then
# line 60 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p+1
 begin  emit :colon        end
		end
when 30 then
# line 61 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p+1
 begin  emit :prop         end
		end
when 31 then
# line 62 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p+1
 begin  emit :comma        end
		end
when 32 then
# line 63 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p+1
 begin  line.call          end
		end
when 33 then
# line 64 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p+1
 begin                     end
		end
when 34 then
# line 65 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p+1
 begin  error              end
		end
when 35 then
# line 38 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p
    @p =     @p - 1; begin  emit :number       end
		end
when 36 then
# line 40 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p
    @p =     @p - 1; begin  emit :dstring      end
		end
when 37 then
# line 41 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p
    @p =     @p - 1; begin  emit :istring      end
		end
when 38 then
# line 49 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p
    @p =     @p - 1; begin  emit :binop        end
		end
when 39 then
# line 51 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p
    @p =     @p - 1; begin  emit :identifier   end
		end
when 40 then
# line 38 "lib/liquidscript/scanner/lexer.rl"
		begin
 begin     @p = (( @te))-1; end
 begin  emit :number       end
		end
when 41 then
# line 1 "NONE"
		begin
	case  @act
	when 2 then
	begin begin     @p = (( @te))-1; end
 emit :sstring     end
	when 3 then
	begin begin     @p = (( @te))-1; end
 emit :dstring     end
	when 4 then
	begin begin     @p = (( @te))-1; end
 emit :istring     end
	when 5 then
	begin begin     @p = (( @te))-1; end
 emit :class       end
	when 6 then
	begin begin     @p = (( @te))-1; end
 emit :module      end
	when 7 then
	begin begin     @p = (( @te))-1; end
 emit :if          end
	when 8 then
	begin begin     @p = (( @te))-1; end
 emit :unless      end
	when 9 then
	begin begin     @p = (( @te))-1; end
 emit :elsif       end
	when 10 then
	begin begin     @p = (( @te))-1; end
 emit :else        end
	when 11 then
	begin begin     @p = (( @te))-1; end
 emit :unop        end
	when 12 then
	begin begin     @p = (( @te))-1; end
 emit :binop       end
	when 13 then
	begin begin     @p = (( @te))-1; end
 emit :keyword     end
	when 14 then
	begin begin     @p = (( @te))-1; end
 emit :identifier  end
	when 16 then
	begin begin     @p = (( @te))-1; end
 emit :equal       end
	when 28 then
	begin begin     @p = (( @te))-1; end
 error             end
end 
			end
# line 808 "lib/liquidscript/scanner/lexer.rb"
			end # action switch
		end
	end
	if _trigger_goto
		next
	end
	end
	if _goto_level <= _again
	_acts = _lexer_to_state_actions[ @cs]
	_nacts = _lexer_actions[_acts]
	_acts += 1
	while _nacts > 0
		_nacts -= 1
		_acts += 1
		case _lexer_actions[_acts - 1]
when 0 then
# line 1 "NONE"
		begin
 @ts = nil;		end
# line 828 "lib/liquidscript/scanner/lexer.rb"
		end # to state action switch
	end
	if _trigger_goto
		next
	end
	    @p += 1
	if     @p !=    @pe
		_goto_level = _resume
		next
	end
	end
	if _goto_level <= _test_eof
	if     @p ==   @eof
	if _lexer_eof_trans[ @cs] > 0
		_trans = _lexer_eof_trans[ @cs] - 1;
		_goto_level = _eof_trans
		next;
	end
end
	end
	if _goto_level <= _out
		break
	end
	end
	end

# line 123 "lib/liquidscript/scanner/lexer.rl"

        clean!

        @tokens
      end
    end
  end
end
