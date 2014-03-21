require "forwardable"
require "liquidscript/icr"
require "liquidscript/errors"
require "liquidscript/version"
require "liquidscript/scanner"
require "liquidscript/compiler"
require "liquidscript/generator"

if defined? ::Sprockets
  require "liquidscript/template"
end

module Liquidscript
  def self.compile(data)
    compiler = Compiler::ICR.new(s = Scanner::Liquidscript.new(data))
    compiler.compile
    Generator::Javascript.new(compiler.top).generate
  end
end
