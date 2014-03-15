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
        [:lbrace, nil],
        [:identifier, "test"],
        [:equal, nil],
        [:number, "3"],
        [:rbrace, nil]
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

    it "scans heredocs" do
      scan("<<TEST\nhello\nTEST\n").should eq [
        [:heredoc_ref, "TEST"],
        [:heredoc, "hello"]
      ]

      scan("<<-TEST\nhello \#{world}\nTEST\n").should eq [
        [:iheredoc_ref, "TEST"],
        [:iheredoc_begin, "hello "],
        [:identifier, "world"],
        [:iheredoc, ""]
      ]

      scan("hello <<TEST world\nin heredoc\nTEST\n").should eq [
        [:identifier, "hello"],
        [:heredoc_ref, "TEST"],
        [:identifier, "world"],
        [:heredoc, "in heredoc"]
      ]
    end
  end
end
