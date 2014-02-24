
# line 1 "lib/liquidscript/scanner/lexer.rl"

# line 26 "lib/liquidscript/scanner/lexer.rl"


module Liquidscript
  class Scanner

    class SyntaxError < StandardError; end
    class Lexer

      attr_reader :tokens

      def initialize
        
# line 18 "lib/liquidscript/scanner/lexer.rb"
class << self
	attr_accessor :_lexer_actions
	private :_lexer_actions, :_lexer_actions=
end
self._lexer_actions = [
	0, 1, 2, 1, 3, 1, 8, 1, 
	9, 1, 10, 1, 11, 1, 12, 1, 
	13, 1, 14, 1, 15, 1, 16, 1, 
	17, 1, 18, 1, 19, 2, 0, 1, 
	2, 3, 4, 2, 3, 5, 2, 3, 
	6, 2, 3, 7
]

class << self
	attr_accessor :_lexer_key_offsets
	private :_lexer_key_offsets, :_lexer_key_offsets=
end
self._lexer_key_offsets = [
	0, 0, 2, 4, 6, 8, 10, 12, 
	16, 18, 33, 35, 37, 42, 46, 48, 
	58, 64, 72
]

class << self
	attr_accessor :_lexer_trans_keys
	private :_lexer_trans_keys, :_lexer_trans_keys=
end
self._lexer_trans_keys = [
	34, 92, 34, 92, 39, 92, 39, 92, 
	48, 57, 48, 57, 43, 45, 48, 57, 
	48, 57, 32, 34, 39, 45, 61, 123, 
	125, 9, 13, 48, 57, 65, 90, 97, 
	122, 34, 92, 39, 92, 46, 69, 101, 
	49, 57, 69, 101, 48, 57, 48, 57, 
	46, 48, 69, 101, 49, 57, 65, 90, 
	97, 122, 48, 57, 65, 90, 97, 122, 
	43, 45, 48, 57, 65, 90, 97, 122, 
	48, 57, 65, 90, 97, 122, 0
]

class << self
	attr_accessor :_lexer_single_lengths
	private :_lexer_single_lengths, :_lexer_single_lengths=
end
self._lexer_single_lengths = [
	0, 2, 2, 2, 2, 0, 0, 2, 
	0, 7, 2, 2, 3, 2, 0, 4, 
	0, 2, 0
]

class << self
	attr_accessor :_lexer_range_lengths
	private :_lexer_range_lengths, :_lexer_range_lengths=
end
self._lexer_range_lengths = [
	0, 0, 0, 0, 0, 1, 1, 1, 
	1, 4, 0, 0, 1, 1, 1, 3, 
	3, 3, 3
]

class << self
	attr_accessor :_lexer_index_offsets
	private :_lexer_index_offsets, :_lexer_index_offsets=
end
self._lexer_index_offsets = [
	0, 0, 3, 6, 9, 12, 14, 16, 
	20, 22, 34, 37, 40, 45, 49, 51, 
	59, 63, 69
]

class << self
	attr_accessor :_lexer_indicies
	private :_lexer_indicies, :_lexer_indicies=
end
self._lexer_indicies = [
	2, 3, 1, 4, 3, 1, 6, 7, 
	5, 8, 7, 5, 9, 10, 12, 11, 
	13, 13, 14, 11, 14, 0, 15, 1, 
	5, 16, 18, 20, 21, 15, 17, 19, 
	19, 10, 2, 3, 1, 6, 7, 5, 
	25, 26, 26, 9, 24, 26, 26, 12, 
	24, 14, 24, 25, 19, 27, 27, 17, 
	19, 19, 24, 19, 19, 19, 28, 13, 
	13, 29, 19, 19, 28, 29, 19, 19, 
	24, 0
]

class << self
	attr_accessor :_lexer_trans_targs
	private :_lexer_trans_targs, :_lexer_trans_targs=
end
self._lexer_trans_targs = [
	9, 1, 9, 2, 10, 3, 9, 4, 
	11, 12, 0, 9, 13, 8, 14, 9, 
	5, 15, 9, 16, 9, 9, 9, 9, 
	9, 6, 7, 17, 9, 18
]

class << self
	attr_accessor :_lexer_trans_actions
	private :_lexer_trans_actions, :_lexer_trans_actions=
end
self._lexer_trans_actions = [
	27, 0, 5, 0, 35, 0, 7, 0, 
	38, 32, 0, 25, 32, 0, 0, 15, 
	0, 3, 9, 0, 11, 13, 19, 21, 
	17, 0, 0, 41, 23, 0
]

class << self
	attr_accessor :_lexer_to_state_actions
	private :_lexer_to_state_actions, :_lexer_to_state_actions=
end
self._lexer_to_state_actions = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 29, 0, 0, 0, 0, 0, 0, 
	0, 0, 0
]

class << self
	attr_accessor :_lexer_from_state_actions
	private :_lexer_from_state_actions, :_lexer_from_state_actions=
end
self._lexer_from_state_actions = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 1, 0, 0, 0, 0, 0, 0, 
	0, 0, 0
]

class << self
	attr_accessor :_lexer_eof_trans
	private :_lexer_eof_trans, :_lexer_eof_trans=
end
self._lexer_eof_trans = [
	0, 1, 1, 1, 1, 0, 12, 12, 
	1, 0, 23, 24, 25, 25, 25, 25, 
	29, 29, 25
]

class << self
	attr_accessor :lexer_start
end
self.lexer_start = 9;
class << self
	attr_accessor :lexer_first_final
end
self.lexer_first_final = 9;
class << self
	attr_accessor :lexer_error
end
self.lexer_error = 0;

class << self
	attr_accessor :lexer_en_main
end
self.lexer_en_main = 9;


# line 38 "lib/liquidscript/scanner/lexer.rl"
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

        
# line 193 "lib/liquidscript/scanner/lexer.rb"
begin
	p ||= 0
	pe ||= data.length
	cs = lexer_start
	ts = nil
	te = nil
	act = 0
end

# line 53 "lib/liquidscript/scanner/lexer.rl"

        emit = lambda do |type|
          self.emit(type, data[ts..(te - 1)])
        end

        
# line 210 "lib/liquidscript/scanner/lexer.rb"
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
	if p == pe
		_goto_level = _test_eof
		next
	end
	if cs == 0
		_goto_level = _out
		next
	end
	end
	if _goto_level <= _resume
	_acts = _lexer_from_state_actions[cs]
	_nacts = _lexer_actions[_acts]
	_acts += 1
	while _nacts > 0
		_nacts -= 1
		_acts += 1
		case _lexer_actions[_acts - 1]
			when 2 then
# line 1 "NONE"
		begin
ts = p
		end
# line 244 "lib/liquidscript/scanner/lexer.rb"
		end # from state action switch
	end
	if _trigger_goto
		next
	end
	_keys = _lexer_key_offsets[cs]
	_trans = _lexer_index_offsets[cs]
	_klen = _lexer_single_lengths[cs]
	_break_match = false
	
	begin
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + _klen - 1

	     loop do
	        break if _upper < _lower
	        _mid = _lower + ( (_upper - _lower) >> 1 )

	        if data[p].ord < _lexer_trans_keys[_mid]
	           _upper = _mid - 1
	        elsif data[p].ord > _lexer_trans_keys[_mid]
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
	  _klen = _lexer_range_lengths[cs]
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + (_klen << 1) - 2
	     loop do
	        break if _upper < _lower
	        _mid = _lower + (((_upper-_lower) >> 1) & ~1)
	        if data[p].ord < _lexer_trans_keys[_mid]
	          _upper = _mid - 2
	        elsif data[p].ord > _lexer_trans_keys[_mid+1]
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
	cs = _lexer_trans_targs[_trans]
	if _lexer_trans_actions[_trans] != 0
		_acts = _lexer_trans_actions[_trans]
		_nacts = _lexer_actions[_acts]
		_acts += 1
		while _nacts > 0
			_nacts -= 1
			_acts += 1
			case _lexer_actions[_acts - 1]
when 3 then
# line 1 "NONE"
		begin
te = p+1
		end
when 4 then
# line 17 "lib/liquidscript/scanner/lexer.rl"
		begin
act = 1;		end
when 5 then
# line 18 "lib/liquidscript/scanner/lexer.rl"
		begin
act = 2;		end
when 6 then
# line 19 "lib/liquidscript/scanner/lexer.rl"
		begin
act = 3;		end
when 7 then
# line 20 "lib/liquidscript/scanner/lexer.rl"
		begin
act = 4;		end
when 8 then
# line 18 "lib/liquidscript/scanner/lexer.rl"
		begin
te = p+1
 begin  emit.(:dstring)  end
		end
when 9 then
# line 19 "lib/liquidscript/scanner/lexer.rl"
		begin
te = p+1
 begin  emit.(:sstring)  end
		end
when 10 then
# line 21 "lib/liquidscript/scanner/lexer.rl"
		begin
te = p+1
 begin  emit.(:equal)  end
		end
when 11 then
# line 22 "lib/liquidscript/scanner/lexer.rl"
		begin
te = p+1
 begin  emit.(:lbrack)  end
		end
when 12 then
# line 23 "lib/liquidscript/scanner/lexer.rl"
		begin
te = p+1
 begin  emit.(:rbrack)  end
		end
when 13 then
# line 24 "lib/liquidscript/scanner/lexer.rl"
		begin
te = p+1
		end
when 14 then
# line 17 "lib/liquidscript/scanner/lexer.rl"
		begin
te = p
p = p - 1; begin  emit.(:number)  end
		end
when 15 then
# line 18 "lib/liquidscript/scanner/lexer.rl"
		begin
te = p
p = p - 1; begin  emit.(:dstring)  end
		end
when 16 then
# line 19 "lib/liquidscript/scanner/lexer.rl"
		begin
te = p
p = p - 1; begin  emit.(:sstring)  end
		end
when 17 then
# line 20 "lib/liquidscript/scanner/lexer.rl"
		begin
te = p
p = p - 1; begin  emit.(:identifier)  end
		end
when 18 then
# line 17 "lib/liquidscript/scanner/lexer.rl"
		begin
 begin p = ((te))-1; end
 begin  emit.(:number)  end
		end
when 19 then
# line 1 "NONE"
		begin
	case act
	when 0 then
	begin	begin
		cs = 0
		_trigger_goto = true
		_goto_level = _again
		break
	end
end
	when 1 then
	begin begin p = ((te))-1; end
 emit.(:number) end
	when 2 then
	begin begin p = ((te))-1; end
 emit.(:dstring) end
	when 3 then
	begin begin p = ((te))-1; end
 emit.(:sstring) end
	when 4 then
	begin begin p = ((te))-1; end
 emit.(:identifier) end
end 
			end
# line 423 "lib/liquidscript/scanner/lexer.rb"
			end # action switch
		end
	end
	if _trigger_goto
		next
	end
	end
	if _goto_level <= _again
	_acts = _lexer_to_state_actions[cs]
	_nacts = _lexer_actions[_acts]
	_acts += 1
	while _nacts > 0
		_nacts -= 1
		_acts += 1
		case _lexer_actions[_acts - 1]
when 0 then
# line 1 "NONE"
		begin
ts = nil;		end
when 1 then
# line 1 "NONE"
		begin
act = 0
		end
# line 448 "lib/liquidscript/scanner/lexer.rb"
		end # to state action switch
	end
	if _trigger_goto
		next
	end
	if cs == 0
		_goto_level = _out
		next
	end
	p += 1
	if p != pe
		_goto_level = _resume
		next
	end
	end
	if _goto_level <= _test_eof
	if p == eof
	if _lexer_eof_trans[cs] > 0
		_trans = _lexer_eof_trans[cs] - 1;
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

# line 59 "lib/liquidscript/scanner/lexer.rl"

        @tokens
      end
    end
  end
end
