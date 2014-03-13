module LexerHelper
  def scan(source)
    described_class.new(source).scan.tokens
  end
end
