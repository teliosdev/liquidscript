
# line 1 "lib/liquidscript/scanner/lexer.rl"

# line 56 "lib/liquidscript/scanner/lexer.rl"


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
	17, 1, 18, 1, 19, 1, 20, 1, 
	21, 1, 22, 1, 23, 1, 24, 1, 
	25, 1, 26, 1, 27, 1, 28, 1, 
	29, 1, 30, 1, 31, 1, 32, 1, 
	33, 1, 34, 1, 35, 1, 36, 1, 
	37, 2, 2, 3, 2, 2, 4, 2, 
	2, 5, 2, 2, 6, 2, 2, 7, 
	2, 2, 8, 2, 2, 9, 2, 2, 
	10, 2, 2, 11, 2, 2, 12, 2, 
	2, 13, 2, 2, 14, 2, 2, 15, 
	2, 2, 16
]

class << self
	attr_accessor :_lexer_key_offsets
	private :_lexer_key_offsets, :_lexer_key_offsets=
end
self._lexer_key_offsets = [
	0, 2, 4, 6, 10, 12, 58, 59, 
	60, 62, 70, 71, 80, 81, 85, 90, 
	94, 96, 98, 100, 101, 110, 119, 128, 
	137, 146, 155, 164, 173, 183, 192, 201, 
	210, 219, 228, 238, 247, 256, 265, 274, 
	283, 292, 301, 310, 319, 328, 337, 346, 
	355, 365, 374, 383, 392, 401, 410, 419, 
	428, 437, 446, 456, 465, 474, 483, 492, 
	501, 510, 520, 529, 538, 547, 556, 565, 
	574, 583, 592, 601
]

class << self
	attr_accessor :_lexer_trans_keys
	private :_lexer_trans_keys, :_lexer_trans_keys=
end
self._lexer_trans_keys = [
	34, 92, 34, 92, 48, 57, 43, 45, 
	48, 57, 48, 57, 10, 32, 33, 34, 
	36, 38, 39, 40, 41, 43, 44, 45, 
	46, 58, 60, 61, 62, 91, 93, 94, 
	95, 97, 99, 101, 102, 105, 109, 110, 
	111, 114, 116, 117, 123, 124, 125, 126, 
	9, 13, 42, 47, 48, 57, 65, 90, 
	98, 122, 61, 61, 34, 92, 36, 95, 
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
	2, 2, 0, 2, 0, 36, 1, 1, 
	2, 2, 1, 3, 1, 2, 3, 2, 
	0, 0, 2, 1, 3, 3, 3, 3, 
	3, 3, 3, 3, 4, 3, 3, 3, 
	3, 3, 4, 3, 3, 3, 3, 3, 
	3, 3, 3, 3, 3, 3, 3, 3, 
	4, 3, 3, 3, 3, 3, 3, 3, 
	3, 3, 4, 3, 3, 3, 3, 3, 
	3, 4, 3, 3, 3, 3, 3, 3, 
	3, 3, 3, 1
]

class << self
	attr_accessor :_lexer_range_lengths
	private :_lexer_range_lengths, :_lexer_range_lengths=
end
self._lexer_range_lengths = [
	0, 0, 1, 1, 1, 5, 0, 0, 
	0, 3, 0, 3, 0, 1, 1, 1, 
	1, 1, 0, 0, 3, 3, 3, 3, 
	3, 3, 3, 3, 3, 3, 3, 3, 
	3, 3, 3, 3, 3, 3, 3, 3, 
	3, 3, 3, 3, 3, 3, 3, 3, 
	3, 3, 3, 3, 3, 3, 3, 3, 
	3, 3, 3, 3, 3, 3, 3, 3, 
	3, 3, 3, 3, 3, 3, 3, 3, 
	3, 3, 3, 0
]

class << self
	attr_accessor :_lexer_index_offsets
	private :_lexer_index_offsets, :_lexer_index_offsets=
end
self._lexer_index_offsets = [
	0, 3, 6, 8, 12, 14, 56, 58, 
	60, 63, 69, 71, 78, 80, 84, 89, 
	93, 95, 97, 100, 102, 109, 116, 123, 
	130, 137, 144, 151, 158, 166, 173, 180, 
	187, 194, 201, 209, 216, 223, 230, 237, 
	244, 251, 258, 265, 272, 279, 286, 293, 
	300, 308, 315, 322, 329, 336, 343, 350, 
	357, 364, 371, 379, 386, 393, 400, 407, 
	414, 421, 429, 436, 443, 450, 457, 464, 
	471, 478, 485, 492
]

class << self
	attr_accessor :_lexer_indicies
	private :_lexer_indicies, :_lexer_indicies=
end
self._lexer_indicies = [
	2, 3, 1, 4, 3, 1, 6, 5, 
	7, 7, 8, 5, 8, 5, 11, 10, 
	12, 13, 14, 15, 16, 17, 18, 20, 
	21, 22, 23, 25, 26, 27, 28, 29, 
	30, 19, 14, 31, 32, 33, 34, 35, 
	36, 37, 38, 39, 40, 41, 42, 43, 
	44, 45, 10, 19, 24, 14, 14, 9, 
	46, 0, 19, 47, 2, 3, 1, 14, 
	14, 14, 14, 14, 0, 19, 47, 48, 
	48, 48, 48, 48, 48, 0, 45, 47, 
	45, 49, 24, 47, 51, 52, 52, 24, 
	50, 52, 52, 6, 50, 8, 50, 19, 
	47, 19, 53, 47, 19, 47, 14, 14, 
	55, 14, 14, 14, 54, 14, 14, 56, 
	14, 14, 14, 54, 14, 14, 57, 14, 
	14, 14, 54, 14, 14, 58, 14, 14, 
	14, 54, 14, 14, 59, 14, 14, 14, 
	54, 14, 14, 60, 14, 14, 14, 54, 
	14, 14, 61, 14, 14, 14, 54, 14, 
	14, 62, 14, 14, 14, 54, 14, 14, 
	63, 64, 14, 14, 14, 54, 14, 14, 
	65, 14, 14, 14, 54, 14, 14, 66, 
	14, 14, 14, 54, 14, 14, 67, 14, 
	14, 14, 54, 14, 14, 68, 14, 14, 
	14, 54, 14, 14, 69, 14, 14, 14, 
	54, 14, 14, 70, 71, 14, 14, 14, 
	54, 14, 14, 72, 14, 14, 14, 54, 
	14, 14, 73, 14, 14, 14, 54, 14, 
	14, 74, 14, 14, 14, 54, 14, 14, 
	75, 14, 14, 14, 54, 14, 14, 76, 
	14, 14, 14, 54, 14, 14, 77, 14, 
	14, 14, 54, 14, 14, 78, 14, 14, 
	14, 54, 14, 14, 56, 14, 14, 14, 
	54, 14, 14, 79, 14, 14, 14, 54, 
	14, 14, 80, 14, 14, 14, 54, 14, 
	14, 81, 14, 14, 14, 54, 14, 14, 
	82, 14, 14, 14, 54, 14, 14, 83, 
	14, 14, 14, 54, 14, 14, 84, 85, 
	14, 14, 14, 54, 14, 14, 86, 14, 
	14, 14, 54, 14, 14, 87, 14, 14, 
	14, 54, 14, 14, 69, 14, 14, 14, 
	54, 14, 14, 56, 14, 14, 14, 54, 
	14, 14, 88, 14, 14, 14, 54, 14, 
	14, 89, 14, 14, 14, 54, 14, 14, 
	90, 14, 14, 14, 54, 14, 14, 91, 
	14, 14, 14, 54, 14, 14, 86, 14, 
	14, 14, 54, 14, 14, 92, 93, 14, 
	14, 14, 54, 14, 14, 68, 14, 14, 
	14, 54, 14, 14, 94, 14, 14, 14, 
	54, 14, 14, 95, 14, 14, 14, 54, 
	14, 14, 96, 14, 14, 14, 54, 14, 
	14, 86, 14, 14, 14, 54, 14, 14, 
	97, 14, 14, 14, 54, 14, 14, 98, 
	99, 14, 14, 14, 54, 14, 14, 100, 
	14, 14, 14, 54, 14, 14, 101, 14, 
	14, 14, 54, 14, 14, 102, 14, 14, 
	14, 54, 14, 14, 103, 14, 14, 14, 
	54, 14, 14, 104, 14, 14, 14, 54, 
	14, 14, 69, 14, 14, 14, 54, 14, 
	14, 105, 14, 14, 14, 54, 14, 14, 
	106, 14, 14, 14, 54, 14, 14, 107, 
	14, 14, 14, 54, 19, 47, 0
]

class << self
	attr_accessor :_lexer_trans_targs
	private :_lexer_trans_targs, :_lexer_trans_targs=
end
self._lexer_trans_targs = [
	5, 0, 5, 1, 8, 5, 15, 4, 
	16, 5, 5, 5, 6, 8, 9, 10, 
	11, 5, 5, 5, 12, 5, 13, 5, 
	14, 5, 17, 6, 18, 5, 5, 20, 
	22, 26, 30, 34, 43, 48, 52, 53, 
	58, 64, 5, 75, 5, 5, 7, 5, 
	11, 5, 5, 2, 3, 19, 5, 21, 
	9, 23, 24, 25, 9, 27, 28, 9, 
	29, 9, 31, 32, 33, 9, 9, 35, 
	36, 37, 38, 39, 40, 41, 42, 44, 
	45, 46, 47, 9, 49, 50, 9, 51, 
	54, 55, 56, 57, 59, 60, 61, 62, 
	63, 65, 66, 72, 67, 68, 69, 70, 
	71, 73, 74, 9
]

class << self
	attr_accessor :_lexer_trans_actions
	private :_lexer_trans_actions, :_lexer_trans_actions=
end
self._lexer_trans_actions = [
	47, 0, 7, 0, 49, 45, 5, 0, 
	0, 37, 35, 33, 73, 88, 82, 0, 
	88, 17, 23, 11, 0, 31, 0, 29, 
	5, 27, 0, 85, 0, 19, 25, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 15, 0, 21, 9, 0, 41, 
	52, 13, 39, 0, 0, 0, 43, 0, 
	76, 0, 0, 0, 55, 0, 0, 70, 
	0, 67, 0, 0, 0, 79, 61, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 58, 0, 0, 73, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 64
]

class << self
	attr_accessor :_lexer_to_state_actions
	private :_lexer_to_state_actions, :_lexer_to_state_actions=
end
self._lexer_to_state_actions = [
	0, 0, 0, 0, 0, 1, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0
]

class << self
	attr_accessor :_lexer_from_state_actions
	private :_lexer_from_state_actions, :_lexer_from_state_actions=
end
self._lexer_from_state_actions = [
	0, 0, 0, 0, 0, 3, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0
]

class << self
	attr_accessor :_lexer_eof_trans
	private :_lexer_eof_trans, :_lexer_eof_trans=
end
self._lexer_eof_trans = [
	1, 1, 6, 6, 6, 0, 1, 48, 
	1, 1, 48, 1, 48, 48, 51, 51, 
	51, 48, 48, 48, 55, 55, 55, 55, 
	55, 55, 55, 55, 55, 55, 55, 55, 
	55, 55, 55, 55, 55, 55, 55, 55, 
	55, 55, 55, 55, 55, 55, 55, 55, 
	55, 55, 55, 55, 55, 55, 55, 55, 
	55, 55, 55, 55, 55, 55, 55, 55, 
	55, 55, 55, 55, 55, 55, 55, 55, 
	55, 55, 55, 48
]

class << self
	attr_accessor :lexer_start
end
self.lexer_start = 5;
class << self
	attr_accessor :lexer_first_final
end
self.lexer_first_final = 5;
class << self
	attr_accessor :lexer_error
end
self.lexer_error = -1;

class << self
	attr_accessor :lexer_en_main
end
self.lexer_en_main = 5;


# line 70 "lib/liquidscript/scanner/lexer.rl"
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

        
# line 413 "lib/liquidscript/scanner/lexer.rb"
begin
	    @p ||= 0
	   @pe ||=  @data.length
	 @cs = lexer_start
	 @ts = nil
	 @te = nil
	 @act = 0
end

# line 110 "lib/liquidscript/scanner/lexer.rl"
        
# line 425 "lib/liquidscript/scanner/lexer.rb"
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
# line 455 "lib/liquidscript/scanner/lexer.rb"
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
# line 29 "lib/liquidscript/scanner/lexer.rl"
		begin
 @act = 2;		end
when 4 then
# line 30 "lib/liquidscript/scanner/lexer.rl"
		begin
 @act = 3;		end
when 5 then
# line 31 "lib/liquidscript/scanner/lexer.rl"
		begin
 @act = 4;		end
when 6 then
# line 32 "lib/liquidscript/scanner/lexer.rl"
		begin
 @act = 5;		end
when 7 then
# line 33 "lib/liquidscript/scanner/lexer.rl"
		begin
 @act = 6;		end
when 8 then
# line 34 "lib/liquidscript/scanner/lexer.rl"
		begin
 @act = 7;		end
when 9 then
# line 35 "lib/liquidscript/scanner/lexer.rl"
		begin
 @act = 8;		end
when 10 then
# line 36 "lib/liquidscript/scanner/lexer.rl"
		begin
 @act = 9;		end
when 11 then
# line 37 "lib/liquidscript/scanner/lexer.rl"
		begin
 @act = 10;		end
when 12 then
# line 38 "lib/liquidscript/scanner/lexer.rl"
		begin
 @act = 11;		end
when 13 then
# line 39 "lib/liquidscript/scanner/lexer.rl"
		begin
 @act = 12;		end
when 14 then
# line 40 "lib/liquidscript/scanner/lexer.rl"
		begin
 @act = 13;		end
when 15 then
# line 42 "lib/liquidscript/scanner/lexer.rl"
		begin
 @act = 15;		end
when 16 then
# line 54 "lib/liquidscript/scanner/lexer.rl"
		begin
 @act = 27;		end
when 17 then
# line 29 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p+1
 begin  emit :dstring      end
		end
when 18 then
# line 37 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p+1
 begin  emit :unop         end
		end
when 19 then
# line 38 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p+1
 begin  emit :binop        end
		end
when 20 then
# line 41 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p+1
 begin  emit :arrow        end
		end
when 21 then
# line 43 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p+1
 begin  emit :lbrack       end
		end
when 22 then
# line 44 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p+1
 begin  emit :lparen       end
		end
when 23 then
# line 45 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p+1
 begin  emit :lbrace       end
		end
when 24 then
# line 46 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p+1
 begin  emit :rbrack       end
		end
when 25 then
# line 47 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p+1
 begin  emit :rparen       end
		end
when 26 then
# line 48 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p+1
 begin  emit :rbrace       end
		end
when 27 then
# line 49 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p+1
 begin  emit :colon        end
		end
when 28 then
# line 50 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p+1
 begin  emit :prop         end
		end
when 29 then
# line 51 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p+1
 begin  emit :comma        end
		end
when 30 then
# line 52 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p+1
 begin  line.call          end
		end
when 31 then
# line 53 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p+1
 begin                     end
		end
when 32 then
# line 54 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p+1
 begin  error              end
		end
when 33 then
# line 28 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p
    @p =     @p - 1; begin  emit :number       end
		end
when 34 then
# line 38 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p
    @p =     @p - 1; begin  emit :binop        end
		end
when 35 then
# line 40 "lib/liquidscript/scanner/lexer.rl"
		begin
 @te =     @p
    @p =     @p - 1; begin  emit :identifier   end
		end
when 36 then
# line 28 "lib/liquidscript/scanner/lexer.rl"
		begin
 begin     @p = (( @te))-1; end
 begin  emit :number       end
		end
when 37 then
# line 1 "NONE"
		begin
	case  @act
	when 2 then
	begin begin     @p = (( @te))-1; end
 emit :dstring     end
	when 3 then
	begin begin     @p = (( @te))-1; end
 emit :sstring     end
	when 4 then
	begin begin     @p = (( @te))-1; end
 emit :class       end
	when 5 then
	begin begin     @p = (( @te))-1; end
 emit :module      end
	when 6 then
	begin begin     @p = (( @te))-1; end
 emit :if          end
	when 7 then
	begin begin     @p = (( @te))-1; end
 emit :unless      end
	when 8 then
	begin begin     @p = (( @te))-1; end
 emit :elsif       end
	when 9 then
	begin begin     @p = (( @te))-1; end
 emit :else        end
	when 10 then
	begin begin     @p = (( @te))-1; end
 emit :unop        end
	when 11 then
	begin begin     @p = (( @te))-1; end
 emit :binop       end
	when 12 then
	begin begin     @p = (( @te))-1; end
 emit :keyword     end
	when 13 then
	begin begin     @p = (( @te))-1; end
 emit :identifier  end
	when 15 then
	begin begin     @p = (( @te))-1; end
 emit :equal       end
	when 27 then
	begin begin     @p = (( @te))-1; end
 error             end
end 
			end
# line 751 "lib/liquidscript/scanner/lexer.rb"
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
# line 771 "lib/liquidscript/scanner/lexer.rb"
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

# line 111 "lib/liquidscript/scanner/lexer.rl"

        clean!

        @tokens
      end
    end
  end
end
