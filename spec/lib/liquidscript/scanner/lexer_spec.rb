require "spec_helper"

describe Liquidscript::Scanner::Lexer, :lexer_helper do
  subject { described_class.new }
  describe "#emit" do
    it "pushes a token" do
      subject.instance_exec { @data = "hello"; @ts = 0; @te = 6 }
      subject.emit(:test)
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

      scan(" 'foobar").should eq [
        [:sstring, "'foobar"]
      ]
    end

    it "scans an identifier" do
      scan('test = 4').should eq [
        [:identifier, "test"],
        [:equal, "="],
        [:number, "4"]
      ]
    end

    it "scans brackets" do
      scan("{ test = 3 }").should eq [
        [:lbrack, "{"],
        [:identifier, "test"],
        [:equal, "="],
        [:number, "3"],
        [:rbrack, "}"]
      ]
    end

    it "scans keywords" do
      scan("return test = new foo").should eq [
        [:unop, "return"],
        [:identifier, "test"],
        [:equal, "="],
        [:unop, "new"],
        [:identifier, "foo"]
      ]
    end
  end
end
