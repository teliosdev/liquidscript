module Liquidscript
  module Compiler
    class ICR < Base
      class Heredoc

        attr_reader :name
        attr_accessor :body

        include Liquidscript::ICR::Representable

        def initialize(name, interpolate)
          @name        = name
          @interpolate = interpolate
          @body        = []
        end

        def interpolate?
          !!@interpolate
        end

        def to_a
          [:heredoc, @name, @body]
        end

      end
    end
  end
end
