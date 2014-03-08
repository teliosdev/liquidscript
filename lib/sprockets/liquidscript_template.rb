module Sprockets
  class LiquidscriptTemplate < Template
    def self.default_mime_type
      'application/javascript'
    end

    def render(context)
      @output ||= Liquidscript.compile(data)
    end
  end
end
