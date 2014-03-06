require "liquidscript/generator/base/dsl"
require "liquidscript/generator/base/replacements"

module Liquidscript
  module Generator

    class Base

      include Replacements

      def initialize(top)
        @top = top
      end

      def generate
        replace(@top, {}).to_s
      end

      def buffer
        Buffer.new
      end

    end
  end
end
