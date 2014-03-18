require "liquidscript"
require "sprockets"
require "tilt"

module Sprockets
  class LiquidscriptTemplate < Tilt::Template
    self.default_mime_type = 'application/javascript'
    
    def self.engine_initialized?
      defined? ::Liquidscript
    end
    
    def initialize_engine
      require_template_library "liquidscript"
    end
    
    def prepare; end

    def evaluate(scope, locals, &block)
      @output ||= Liquidscript.compile(data)
    end
  end

  register_engine '.liq', LiquidscriptTemplate
end
