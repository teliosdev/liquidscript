require "spec_helper"

describe Liquidscript::Scanner::Liquidscript, :lexer_helper do

  describe "#perform" do
    it "scans a number" do
      expect(scan("43")).to eq [
        [:number, "43"]
      ]
    end

    it "scans a string" do
      scan('"hello world" ').should eq [
        [:istring, 'hello world']
      ]

      scan(" 'foobar").should eq [
        [:sstring, "'foobar"]
      ]

      scan('"hello #{world}"').should eq [
        [:istring_begin, "hello "],
        [:identifier, "world"],
        [:istring, ""]
      ]
    end

    it "scans an identifier" do
      scan('test = 4').should eq [
        [:identifier, "test"],
        [:equal, nil],
        [:number, "4"]
      ]
    end

    it "scans brackets" do
      scan("{ test = 3 }").should eq [
        [:lbrack, nil],
        [:identifier, "test"],
        [:equal, nil],
        [:number, "3"],
        [:rbrack, nil]
      ]
    end

    it "scans keywords" do
      scan("return test = new foo").should eq [
        [:unop, "return"],
        [:identifier, "test"],
        [:equal, nil],
        [:unop, "new"],
        [:identifier, "foo"]
      ]
    end
  end
end
