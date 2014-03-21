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
        [:preunop, "return"],
        [:identifier, "test"],
        [:equal, nil],
        [:preunop, "new"],
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

    describe "scanning directives" do
      subject { c = described_class.new("#! test thing\n"); c.scan; c }
      its(:metadata) { should eq :directives => [{:command => "test", :args => "thing"}] }
    end
  end
end
