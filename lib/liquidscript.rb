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
  def self.compile(data, options = {})
    scanner = Scanner::Liquidscript.new(data)
    if options[:tokens]
      scanner.each.to_a.to_sexp
    end

    compiler = Compiler::ICR.new(scanner)
    compiler.compile
    if options[:ast]
      compiler.top.to_sexp
    end

    Generator::Javascript.new(compiler.top).generate
  end
end
