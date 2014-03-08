
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
	0, 2, 4, 6, 10, 12, 56, 57, 
	58, 60, 68, 69, 78, 79, 83, 88, 
	92, 94, 96, 98, 99, 108, 117, 126, 
	135, 144, 153, 163, 172, 181, 190, 199, 
	208, 218, 227, 236, 245, 254, 263, 272, 
	281, 290, 299, 308, 317, 326, 335, 345, 
	354, 363, 372, 381, 390, 399, 408, 417, 
	427, 436, 445, 454, 463, 472, 481, 491, 
	500, 509, 518, 527, 536, 545, 554, 563, 
	572
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
	95, 99, 101, 102, 105, 109, 110, 114, 
	116, 117, 123, 124, 125, 126, 9, 13, 
	42, 47, 48, 57, 65, 90, 97, 122, 
	61, 61, 34, 92, 36, 95, 48, 57, 
	65, 90, 97, 122, 38, 36, 45, 95, 
	48, 57, 65, 90, 97, 122, 43, 45, 
	62, 48, 57, 46, 69, 101, 49, 57, 
	69, 101, 48, 57, 48, 57, 60, 61, 
	61, 62, 62, 36, 95, 108, 48, 57, 
	65, 90, 97, 122, 36, 95, 97, 48, 
	57, 65, 90, 98, 122, 36, 95, 115, 
	48, 57, 65, 90, 97, 122, 36, 95, 
	115, 48, 57, 65, 90, 97, 122, 36, 
	95, 108, 48, 57, 65, 90, 97, 122, 
	36, 95, 115, 48, 57, 65, 90, 97, 
	122, 36, 95, 101, 105, 48, 57, 65, 
	90, 97, 122, 36, 95, 102, 48, 57, 
	65, 90, 97, 122, 36, 95, 97, 48, 
	57, 65, 90, 98, 122, 36, 95, 108, 
	48, 57, 65, 90, 97, 122, 36, 95, 
	115, 48, 57, 65, 90, 97, 122, 36, 
	95, 101, 48, 57, 65, 90, 97, 122, 
	36, 95, 102, 110, 48, 57, 65, 90, 
	97, 122, 36, 95, 115, 48, 57, 65, 
	90, 97, 122, 36, 95, 116, 48, 57, 
	65, 90, 97, 122, 36, 95, 97, 48, 
	57, 65, 90, 98, 122, 36, 95, 110, 
	48, 57, 65, 90, 97, 122, 36, 95, 
	99, 48, 57, 65, 90, 97, 122, 36, 
	95, 101, 48, 57, 65, 90, 97, 122, 
	36, 95, 111, 48, 57, 65, 90, 97, 
	122, 36, 95, 102, 48, 57, 65, 90, 
	97, 122, 36, 95, 111, 48, 57, 65, 
	90, 97, 122, 36, 95, 100, 48, 57, 
	65, 90, 97, 122, 36, 95, 117, 48, 
	57, 65, 90, 97, 122, 36, 95, 108, 
	48, 57, 65, 90, 97, 122, 36, 95, 
	101, 48, 57, 65, 90, 97, 122, 36, 
	95, 101, 117, 48, 57, 65, 90, 97, 
	122, 36, 95, 119, 48, 57, 65, 90, 
	97, 122, 36, 95, 108, 48, 57, 65, 
	90, 97, 122, 36, 95, 108, 48, 57, 
	65, 90, 97, 122, 36, 95, 101, 48, 
	57, 65, 90, 97, 122, 36, 95, 116, 
	48, 57, 65, 90, 97, 122, 36, 95, 
	117, 48, 57, 65, 90, 97, 122, 36, 
	95, 114, 48, 57, 65, 90, 97, 122, 
	36, 95, 110, 48, 57, 65, 90, 97, 
	122, 36, 95, 114, 121, 48, 57, 65, 
	90, 97, 122, 36, 95, 117, 48, 57, 
	65, 90, 97, 122, 36, 95, 112, 48, 
	57, 65, 90, 97, 122, 36, 95, 101, 
	48, 57, 65, 90, 97, 122, 36, 95, 
	111, 48, 57, 65, 90, 97, 122, 36, 
	95, 102, 48, 57, 65, 90, 97, 122, 
	36, 95, 110, 48, 57, 65, 90, 97, 
	122, 36, 95, 100, 108, 48, 57, 65, 
	90, 97, 122, 36, 95, 101, 48, 57, 
	65, 90, 97, 122, 36, 95, 102, 48, 
	57, 65, 90, 97, 122, 36, 95, 105, 
	48, 57, 65, 90, 97, 122, 36, 95, 
	110, 48, 57, 65, 90, 97, 122, 36, 
	95, 101, 48, 57, 65, 90, 97, 122, 
	36, 95, 100, 48, 57, 65, 90, 97, 
	122, 36, 95, 101, 48, 57, 65, 90, 
	97, 122, 36, 95, 115, 48, 57, 65, 
	90, 97, 122, 36, 95, 115, 48, 57, 
	65, 90, 97, 122, 124, 0
]

class << self
	attr_accessor :_lexer_single_lengths
	private :_lexer_single_lengths, :_lexer_single_lengths=
end
self._lexer_single_lengths = [
	2, 2, 0, 2, 0, 34, 1, 1, 
	2, 2, 1, 3, 1, 2, 3, 2, 
	0, 0, 2, 1, 3, 3, 3, 3, 
	3, 3, 4, 3, 3, 3, 3, 3, 
	4, 3, 3, 3, 3, 3, 3, 3, 
	3, 3, 3, 3, 3, 3, 4, 3, 
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
	0, 0, 1, 1, 1, 5, 0, 0, 
	0, 3, 0, 3, 0, 1, 1, 1, 
	1, 1, 0, 0, 3, 3, 3, 3, 
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
	0, 3, 6, 8, 12, 14, 54, 56, 
	58, 61, 67, 69, 76, 78, 82, 87, 
	91, 93, 95, 98, 100, 107, 114, 121, 
	128, 135, 142, 150, 157, 164, 171, 178, 
	185, 193, 200, 207, 214, 221, 228, 235, 
	242, 249, 256, 263, 270, 277, 284, 292, 
	299, 306, 313, 320, 327, 334, 341, 348, 
	356, 363, 370, 377, 384, 391, 398, 406, 
	413, 420, 427, 434, 441, 448, 455, 462, 
	469
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
	10, 19, 24, 14, 14, 9, 44, 0, 
	19, 45, 2, 3, 1, 14, 14, 14, 
	14, 14, 0, 19, 45, 46, 46, 46, 
	46, 46, 46, 0, 43, 45, 43, 47, 
	24, 45, 49, 50, 50, 24, 48, 50, 
	50, 6, 48, 8, 48, 19, 45, 19, 
	51, 45, 19, 45, 14, 14, 53, 14, 
	14, 14, 52, 14, 14, 54, 14, 14, 
	14, 52, 14, 14, 55, 14, 14, 14, 
	52, 14, 14, 56, 14, 14, 14, 52, 
	14, 14, 57, 14, 14, 14, 52, 14, 
	14, 58, 14, 14, 14, 52, 14, 14, 
	59, 60, 14, 14, 14, 52, 14, 14, 
	61, 14, 14, 14, 52, 14, 14, 62, 
	14, 14, 14, 52, 14, 14, 63, 14, 
	14, 14, 52, 14, 14, 64, 14, 14, 
	14, 52, 14, 14, 65, 14, 14, 14, 
	52, 14, 14, 66, 67, 14, 14, 14, 
	52, 14, 14, 68, 14, 14, 14, 52, 
	14, 14, 69, 14, 14, 14, 52, 14, 
	14, 70, 14, 14, 14, 52, 14, 14, 
	71, 14, 14, 14, 52, 14, 14, 72, 
	14, 14, 14, 52, 14, 14, 73, 14, 
	14, 14, 52, 14, 14, 74, 14, 14, 
	14, 52, 14, 14, 75, 14, 14, 14, 
	52, 14, 14, 76, 14, 14, 14, 52, 
	14, 14, 77, 14, 14, 14, 52, 14, 
	14, 78, 14, 14, 14, 52, 14, 14, 
	79, 14, 14, 14, 52, 14, 14, 80, 
	14, 14, 14, 52, 14, 14, 81, 82, 
	14, 14, 14, 52, 14, 14, 83, 14, 
	14, 14, 52, 14, 14, 84, 14, 14, 
	14, 52, 14, 14, 65, 14, 14, 14, 
	52, 14, 14, 85, 14, 14, 14, 52, 
	14, 14, 86, 14, 14, 14, 52, 14, 
	14, 87, 14, 14, 14, 52, 14, 14, 
	88, 14, 14, 14, 52, 14, 14, 83, 
	14, 14, 14, 52, 14, 14, 89, 90, 
	14, 14, 14, 52, 14, 14, 64, 14, 
	14, 14, 52, 14, 14, 91, 14, 14, 
	14, 52, 14, 14, 92, 14, 14, 14, 
	52, 14, 14, 93, 14, 14, 14, 52, 
	14, 14, 83, 14, 14, 14, 52, 14, 
	14, 94, 14, 14, 14, 52, 14, 14, 
	95, 96, 14, 14, 14, 52, 14, 14, 
	97, 14, 14, 14, 52, 14, 14, 98, 
	14, 14, 14, 52, 14, 14, 99, 14, 
	14, 14, 52, 14, 14, 100, 14, 14, 
	14, 52, 14, 14, 101, 14, 14, 14, 
	52, 14, 14, 65, 14, 14, 14, 52, 
	14, 14, 102, 14, 14, 14, 52, 14, 
	14, 103, 14, 14, 14, 52, 14, 14, 
	104, 14, 14, 14, 52, 19, 45, 0
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
	24, 28, 32, 41, 46, 50, 55, 61, 
	5, 72, 5, 5, 7, 5, 11, 5, 
	5, 2, 3, 19, 5, 21, 22, 23, 
	9, 25, 26, 9, 27, 9, 29, 30, 
	31, 9, 9, 33, 34, 35, 36, 37, 
	38, 39, 40, 9, 42, 43, 44, 45, 
	9, 47, 48, 9, 49, 51, 52, 53, 
	54, 56, 57, 58, 59, 60, 62, 63, 
	69, 64, 65, 66, 67, 68, 70, 71, 
	9
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
	15, 0, 21, 9, 0, 41, 52, 13, 
	39, 0, 0, 0, 43, 0, 0, 0, 
	55, 0, 0, 70, 0, 67, 0, 0, 
	0, 79, 61, 0, 0, 0, 0, 0, 
	0, 0, 0, 76, 0, 0, 0, 0, 
	58, 0, 0, 73, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	64
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
	0
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
	0
]

class << self
	attr_accessor :_lexer_eof_trans
	private :_lexer_eof_trans, :_lexer_eof_trans=
end
self._lexer_eof_trans = [
	1, 1, 6, 6, 6, 0, 1, 46, 
	1, 1, 46, 1, 46, 46, 49, 49, 
	49, 46, 46, 46, 53, 53, 53, 53, 
	53, 53, 53, 53, 53, 53, 53, 53, 
	53, 53, 53, 53, 53, 53, 53, 53, 
	53, 53, 53, 53, 53, 53, 53, 53, 
	53, 53, 53, 53, 53, 53, 53, 53, 
	53, 53, 53, 53, 53, 53, 53, 53, 
	53, 53, 53, 53, 53, 53, 53, 53, 
	46
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
        end

        
# line 405 "lib/liquidscript/scanner/lexer.rb"
begin
	    @p ||= 0
	   @pe ||=  @data.length
	 @cs = lexer_start
	 @ts = nil
	 @te = nil
	 @act = 0
end

# line 109 "lib/liquidscript/scanner/lexer.rl"
        
# line 417 "lib/liquidscript/scanner/lexer.rb"
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
# line 447 "lib/liquidscript/scanner/lexer.rb"
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
# line 743 "lib/liquidscript/scanner/lexer.rb"
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
# line 763 "lib/liquidscript/scanner/lexer.rb"
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

# line 110 "lib/liquidscript/scanner/lexer.rl"

        clean!

        @tokens
      end
    end
  end
end
