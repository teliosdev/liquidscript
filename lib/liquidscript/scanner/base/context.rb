module Liquidscript
  module Scanner
    class Base
      class Context

        attr_reader :name

        def initialize(name)
          @name = name
          @matches = {}
          @temps = {}
        end

        def find_matcher(with)
          best_match = [0, nil, nil]
          @matches.each do |k, v|
            if with.match?(k) && with.matched_size > best_match[0]
              best_match = [with.matched_size, k, v]
            end
          end

          best_match[1..-1]
        end

        def exit
          EXIT
        end

        def init
          if block_given?
            @init = Proc.new
          else
            @init || proc {}
          end
        end

        def set(key, matcher)
          @temps[key] = matcher
        end

        def get(key)
          normalize_matcher @temps[key]
        end

        def on(matcher)
          key = nil
          value = nil

          if block_given?
            key = normalize_matcher matcher
            value = Proc.new
          else
            key = normalize_matcher matcher.keys.first
            value = matcher.values.first
          end

          @matches[key] = value
        end

        private

        def normalize_matcher(matcher)
          case matcher
          when :_
            /./m
          when String
            Regexp.new(Regexp.escape(matcher))
          when Symbol
            normalize_matcher(@temps[matcher])
          when Array
            union = matcher.map { |m|
              Regexp.escape(m.to_s)
            }.join('|')
            Regexp.new "(#{union})"
          else
            matcher
          end
        end

      end
    end
  end
end
