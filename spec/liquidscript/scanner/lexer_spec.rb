require "spec_helper"

describe Liquidscript::Scanner::Liquidscript, :lexer_helper do

  describe "#perform" do
    it "scans a number" do
      expect(scan("43")).to eq [
        [:number, "43"]
      ]
    end

    it "scans a string" do
      expect(scan('"hello world" ')).to eq [
        [:istring, 'hello world']
      ]

      expect(scan(" 'foobar")).to eq [
        [:sstring, "'foobar"]
      ]

      expect(scan('"hello #{world}"')).to eq [
        [:istring_begin, "hello "],
        [:identifier, "world"],
        [:istring, ""]
      ]
    end

    it "scans an identifier" do
      expect(scan('test = 4')).to eq [
        [:identifier, "test"],
        [:equal, nil],
        [:number, "4"]
      ]
    end

    it "scans brackets" do
      expect(scan("{ test = 3 }")).to eq [
        [:lbrace, nil],
        [:identifier, "test"],
        [:equal, nil],
        [:number, "3"],
        [:rbrace, nil]
      ]
    end

    it "scans keywords" do
      expect(scan("return test = new foo")).to eq [
        [:return, nil],
        [:identifier, "test"],
        [:equal, nil],
        [:preunop, "new"],
        [:identifier, "foo"]
      ]
    end

    it "scans heredocs" do
      expect(scan("<<TEST\nhello\nTEST\n")).to eq [
        [:heredoc_ref, "TEST"],
        [:heredoc, "hello"]
      ]

      expect(scan("<<-TEST\nhello \#{world}\nTEST\n")).to eq [
        [:iheredoc_ref, "TEST"],
        [:iheredoc_begin, "hello "],
        [:identifier, "world"],
        [:iheredoc, ""]
      ]

      expect(scan("hello <<TEST world\nin heredoc\nTEST\n")).to eq [
        [:identifier, "hello"],
        [:heredoc_ref, "TEST"],
        [:identifier, "world"],
        [:heredoc, "in heredoc"]
      ]
    end
  end
end
