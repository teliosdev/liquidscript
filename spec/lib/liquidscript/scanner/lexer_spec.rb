require "spec_helper"

RSpec::Matchers.define :be_token do |type, value|
  match do |data|
    data == Liquidscript::Scanner::Token.new(type, value)
  end

  description do
    "be token #{expected}"
  end
end

describe Liquidscript::Scanner::Lexer, :lexer_helper do
  subject { described_class.new }
  describe "#emit" do
    it "pushes a token" do
      subject.emit(:test, "hello")
      expect(subject.tokens.first).to be_token(:test, "hello")
    end
  end

  describe "#perform" do
    it "scans a number" do
      expect(scan("43")).to eq [
        [:number, "43"]
      ]
    end

    it "scans a string" do
      scan('"hello world" ').should eq [
        [:dstring, '"hello world"']
      ]

      scan(" 'foobar'").should eq [
        [:sstring, "'foobar'"]
      ]
    end

    it "scans an identifier" do
      scan('test = 4').should eq [
        [:identifier, "test"],
        [:equal, "="],
        [:number, "4"]
      ]
    end
  end
end
