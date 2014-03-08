require "forwardable"
require "liquidscript/icr"
require "liquidscript/errors"
require "liquidscript/version"
require "liquidscript/scanner"
require "liquidscript/compiler"
require "liquidscript/generator"
require "liquidscript/template"

module Liquidscript
  def self.compile(data)
    compiler = Compiler::ICR.new(Scanner.new(data))
    compiler.compile
    Generator::Javascript.new(compiler.top)
  end
end
