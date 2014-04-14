require "liquidscript/compiler/icr/expressions"
require "liquidscript/compiler/icr/functions"
require "liquidscript/compiler/icr/literals"
require "liquidscript/compiler/icr/classes"
require "liquidscript/compiler/icr/helpers"
require "liquidscript/compiler/icr/heredoc"
require "liquidscript/compiler/icr/groups"

module Liquidscript
  module Compiler
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

        handle_directives
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

      private

      def handle_directives
        return unless @scanner.metadata[:directives]

        @scanner.metadata[:directives].each do |meta|
          case meta[:command]
          when "allow"
            variables = meta[:args].split(' ')
            variables.each { |v| top.context.allow(v.intern) }
          when "cvar"
            variables = meta[:args].split(' ')
            variables.each { |v| top.context.set(v.intern,
                                 :class => true).parameter! }
          else
            raise UnknownDirectiveError.new(meta[:command])
          end
        end
      end
    end
  end
end
