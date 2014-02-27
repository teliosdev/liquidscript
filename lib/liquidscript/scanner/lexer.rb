
# line 1 "lib/liquidscript/scanner/lexer.rl"

# line 34 "lib/liquidscript/scanner/lexer.rl"


module Liquidscript
  class Scanner

    class Lexer

      attr_reader :tokens

      def initialize
        
# line 17 "lib/liquidscript/scanner/lexer.rb"
class << self
	attr_accessor :_lexer_actions
	private :_lexer_actions, :_lexer_actions=
end
self._lexer_actions = [
	0, 1, 0, 1, 1, 1, 2, 1, 
	6, 1, 7, 1, 8, 1, 9, 1, 
	10, 1, 11, 1, 12, 1, 13, 1, 
	14, 1, 15, 1, 16, 1, 17, 1, 
	18, 1, 19, 1, 20, 1, 21, 1, 
	22, 1, 23, 2, 2, 3, 2, 2, 
	4, 2, 2, 5
]

class << self
	attr_accessor :_lexer_key_offsets
	private :_lexer_key_offsets, :_lexer_key_offsets=
end
self._lexer_key_offsets = [
	0, 2, 4, 6, 10, 12, 35, 37, 
	45, 54, 57, 62, 66
]

class << self
	attr_accessor :_lexer_trans_keys
	private :_lexer_trans_keys, :_lexer_trans_keys=
end
self._lexer_trans_keys = [
	34, 92, 34, 92, 48, 57, 43, 45, 
	48, 57, 48, 57, 32, 34, 36, 39, 
	40, 41, 44, 45, 58, 61, 91, 93, 
	95, 123, 125, 9, 13, 48, 57, 65, 
	90, 97, 122, 34, 92, 36, 95, 48, 
	57, 65, 90, 97, 122, 36, 45, 95, 
	48, 57, 65, 90, 97, 122, 62, 48, 
	57, 46, 69, 101, 49, 57, 69, 101, 
	48, 57, 48, 57, 0
]

class << self
	attr_accessor :_lexer_single_lengths
	private :_lexer_single_lengths, :_lexer_single_lengths=
end
self._lexer_single_lengths = [
	2, 2, 0, 2, 0, 15, 2, 2, 
	3, 1, 3, 2, 0
]

class << self
	attr_accessor :_lexer_range_lengths
	private :_lexer_range_lengths, :_lexer_range_lengths=
end
self._lexer_range_lengths = [
	0, 0, 1, 1, 1, 4, 0, 3, 
	3, 1, 1, 1, 1
]

class << self
	attr_accessor :_lexer_index_offsets
	private :_lexer_index_offsets, :_lexer_index_offsets=
end
self._lexer_index_offsets = [
	0, 3, 6, 8, 12, 14, 34, 37, 
	43, 50, 53, 58, 62
]

class << self
	attr_accessor :_lexer_trans_targs
	private :_lexer_trans_targs, :_lexer_trans_targs=
end
self._lexer_trans_targs = [
	5, 1, 0, 6, 1, 0, 11, 5, 
	4, 4, 12, 5, 12, 5, 5, 6, 
	7, 8, 5, 5, 5, 9, 5, 5, 
	5, 5, 7, 5, 5, 5, 10, 7, 
	7, 5, 5, 1, 0, 7, 7, 7, 
	7, 7, 5, 8, 8, 8, 8, 8, 
	8, 5, 5, 10, 5, 2, 3, 3, 
	10, 5, 3, 3, 11, 5, 12, 5, 
	5, 5, 5, 5, 5, 5, 5, 5, 
	5, 5, 5, 5, 0
]

class << self
	attr_accessor :_lexer_trans_actions
	private :_lexer_trans_actions, :_lexer_trans_actions=
end
self._lexer_trans_actions = [
	7, 0, 0, 43, 0, 0, 5, 39, 
	0, 0, 0, 39, 0, 39, 29, 49, 
	0, 49, 15, 21, 27, 0, 25, 11, 
	17, 23, 0, 13, 19, 29, 5, 0, 
	0, 31, 7, 0, 0, 0, 0, 0, 
	0, 0, 35, 46, 46, 46, 46, 46, 
	46, 41, 9, 5, 37, 0, 0, 0, 
	5, 33, 0, 0, 5, 33, 0, 33, 
	41, 41, 39, 39, 39, 41, 35, 41, 
	37, 33, 33, 33, 0
]

class << self
	attr_accessor :_lexer_to_state_actions
	private :_lexer_to_state_actions, :_lexer_to_state_actions=
end
self._lexer_to_state_actions = [
	0, 0, 0, 0, 0, 1, 0, 0, 
	0, 0, 0, 0, 0
]

class << self
	attr_accessor :_lexer_from_state_actions
	private :_lexer_from_state_actions, :_lexer_from_state_actions=
end
self._lexer_from_state_actions = [
	0, 0, 0, 0, 0, 3, 0, 0, 
	0, 0, 0, 0, 0
]

class << self
	attr_accessor :_lexer_eof_trans
	private :_lexer_eof_trans, :_lexer_eof_trans=
end
self._lexer_eof_trans = [
	72, 72, 69, 69, 69, 0, 72, 71, 
	72, 73, 76, 76, 76
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


# line 45 "lib/liquidscript/scanner/lexer.rl"
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

        
# line 180 "lib/liquidscript/scanner/lexer.rb"
begin
	p ||= 0
	pe ||= data.length
	cs = lexer_start
	ts = nil
	te = nil
	act = 0
end

# line 60 "lib/liquidscript/scanner/lexer.rl"

        emit = lambda do |type|
          self.emit(type, data[ts..(te - 1)])
        end

        error = lambda do
          raise SyntaxError, "Unexpected #{data[ts..(te-1)].pack('c*')}"
        end

        
# line 201 "lib/liquidscript/scanner/lexer.rb"
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
	end
	if _goto_level <= _resume
	_acts = _lexer_from_state_actions[cs]
	_nacts = _lexer_actions[_acts]
	_acts += 1
	while _nacts > 0
		_nacts -= 1
		_acts += 1
		case _lexer_actions[_acts - 1]
			when 1 then
# line 1 "NONE"
		begin
ts = p
		end
# line 231 "lib/liquidscript/scanner/lexer.rb"
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
when 2 then
# line 1 "NONE"
		begin
te = p+1
		end
when 3 then
# line 18 "lib/liquidscript/scanner/lexer.rl"
		begin
act = 2;		end
when 4 then
# line 19 "lib/liquidscript/scanner/lexer.rl"
		begin
act = 3;		end
when 5 then
# line 32 "lib/liquidscript/scanner/lexer.rl"
		begin
act = 16;		end
when 6 then
# line 18 "lib/liquidscript/scanner/lexer.rl"
		begin
te = p+1
 begin  emit.(:dstring)     end
		end
when 7 then
# line 21 "lib/liquidscript/scanner/lexer.rl"
		begin
te = p+1
 begin  emit.(:arrow)       end
		end
when 8 then
# line 22 "lib/liquidscript/scanner/lexer.rl"
		begin
te = p+1
 begin  emit.(:equal)       end
		end
when 9 then
# line 23 "lib/liquidscript/scanner/lexer.rl"
		begin
te = p+1
 begin  emit.(:lbrack)      end
		end
when 10 then
# line 24 "lib/liquidscript/scanner/lexer.rl"
		begin
te = p+1
 begin  emit.(:lparen)      end
		end
when 11 then
# line 25 "lib/liquidscript/scanner/lexer.rl"
		begin
te = p+1
 begin  emit.(:lbrace)      end
		end
when 12 then
# line 26 "lib/liquidscript/scanner/lexer.rl"
		begin
te = p+1
 begin  emit.(:rbrack)      end
		end
when 13 then
# line 27 "lib/liquidscript/scanner/lexer.rl"
		begin
te = p+1
 begin  emit.(:rparen)      end
		end
when 14 then
# line 28 "lib/liquidscript/scanner/lexer.rl"
		begin
te = p+1
 begin  emit.(:rbrace)      end
		end
when 15 then
# line 29 "lib/liquidscript/scanner/lexer.rl"
		begin
te = p+1
 begin  emit.(:colon)       end
		end
when 16 then
# line 30 "lib/liquidscript/scanner/lexer.rl"
		begin
te = p+1
 begin  emit.(:comma)       end
		end
when 17 then
# line 31 "lib/liquidscript/scanner/lexer.rl"
		begin
te = p+1
 begin                      end
		end
when 18 then
# line 32 "lib/liquidscript/scanner/lexer.rl"
		begin
te = p+1
 begin  error.()            end
		end
when 19 then
# line 17 "lib/liquidscript/scanner/lexer.rl"
		begin
te = p
p = p - 1; begin  emit.(:number)      end
		end
when 20 then
# line 20 "lib/liquidscript/scanner/lexer.rl"
		begin
te = p
p = p - 1; begin  emit.(:identifier)  end
		end
when 21 then
# line 32 "lib/liquidscript/scanner/lexer.rl"
		begin
te = p
p = p - 1; begin  error.()            end
		end
when 22 then
# line 17 "lib/liquidscript/scanner/lexer.rl"
		begin
 begin p = ((te))-1; end
 begin  emit.(:number)      end
		end
when 23 then
# line 1 "NONE"
		begin
	case act
	when 2 then
	begin begin p = ((te))-1; end
 emit.(:dstring)    end
	when 3 then
	begin begin p = ((te))-1; end
 emit.(:sstring)    end
	when 16 then
	begin begin p = ((te))-1; end
 error.()           end
end 
			end
# line 431 "lib/liquidscript/scanner/lexer.rb"
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
# line 451 "lib/liquidscript/scanner/lexer.rb"
		end # to state action switch
	end
	if _trigger_goto
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

# line 70 "lib/liquidscript/scanner/lexer.rl"

        @tokens
      end
    end
  end
end
