require "liquidscript/compiler/icr/expressions"
require "liquidscript/compiler/icr/functions"
require "liquidscript/compiler/icr/literals"
require "liquidscript/compiler/icr/classes"
require "liquidscript/compiler/icr/helpers"
require "liquidscript/compiler/icr/heredoc"
require "liquidscript/compiler/icr/groups"

module Liquidscript
  module Compiler

    # A list of codes:
    #
    # - :class
    # - :module
    # - :neg
    # - :pos
    # - :binop
    # - :unop
    # - :set
    # - :expression
    # - :property
    # - :access
    # - :call
    # - :function
    # - :if
    # - :elsif
    # - :unless
    # - :else
    # - :try
    # - :catch
    # - :finally
    # - :nrange
    # - :number
    # - :action
    # - :range
    # - :while
    # - :for_in
    # - :for_seg
    # - :regex
    # - :href
    # - :interop
    # - :istring
    # - :sstring
    # - :operator
    # - :keyword
    # - :object
    # - :array
    # - :newline (depricated)
    class ICR < Base

      include Expressions
      include Functions
      include Literals
      include Classes
      include Helpers
      include Groups

      # (see Base#initialize)
      def initialize(*)
        super
      end

      # (see Base#reset!)
      def reset!
        @top         = Liquidscript::ICR::Set.new
        @top.context = Liquidscript::ICR::Context.new
        @set         = [@top]
        @classes     = {}
        super
      end

      # (see Base#top)
      def top
        @set.last
      end

      # Sets the starting point for compiliation.
      #
      # @return [ICR::Code]
      def compile_start
        compile_expression
      end

      def normalize(s)
        s.map { |x| x.gsub(/\-[a-z]/) { |p| p[1].upcase } }
      end
    end
  end
end
