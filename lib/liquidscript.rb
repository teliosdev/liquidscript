require "forwardable"
require "liquidscript/representable"
require "liquidscript/errors"
require "liquidscript/version"
require "liquidscript/scanner"
require "liquidscript/compiler"
require "liquidscript/generator"

if defined? ::Sprockets
  require "liquidscript/template"
end

module Liquidscript
  def self.compile(data, options)
    scanner = Scanner::Liquidscript.new(data, options[:file])
    if options[:tokens]
      return scanner.each.to_a.to_sexp
    end

    compiler = Compiler::Parser.new(scanner)
    compiler.compile
    if options[:ast]
      return compiler.top.to_sexp
    end

    Generator::Javascript.new(compiler.top).generate
  end
end
