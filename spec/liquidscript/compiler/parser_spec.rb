require "spec_helper"
require "yaml"

describe Compiler::Parser do

  let(:scanner) do
    iterator = double("iterator")
    scanner = double("scanner")

    allow(scanner).to receive(:metadata).and_return({})
    expect(scanner).to receive(:each).once.and_return(iterator)
    allow(iterator).to receive(:next).and_return([
      Scanner::Token.new(:number, "32", 0, 0),
      Scanner::Token.new(:number, "10", 0, 0)])
    allow(iterator).to receive(:peek).and_return(
      Scanner::Token.new(:number, "32", 0, 0))
    allow(iterator).to receive(:rewind)
    scanner
  end

  subject do
    described_class.new(scanner)
  end

  describe "#compile" do
    xspecify {
      expect("hello = 3").to compile.and_produce([:exec,
        [:_context, [:hello]], [:set, [:_variable, :hello], [:number, "3"]]
      ])
    }

    xspecify {
      expect("{hello: 'world}").to compile.and_produce([:exec,
        [:_context, []], [:object, [[[:identifier, "hello"], [:sstring, "world"]]]]
      ])
    }

    xspecify {
      expect("(test)-> { 2 }").to compile.and_produce([:exec,
        [:_context, []], [:function,
          [:exec,
            [:_context, [:test]],
            [:_arguments, [[[:identifier, "test"], nil]]],
            [:number, "2"]
          ]
      ]])
    }


    specify { expect("(2)").to compile                     }
    specify { expect("->(2)").to_not compile               }
    specify { expect("->() {}").to compile                 }
    specify { expect("->(test) {}").to compile             }
    specify { expect("->(test, foo) {}").to compile        }
    specify { expect("blasg()").to compile                 }
    specify { expect("class Test : Variant {}").to compile }
  end

  describe "with fixtures" do
    Dir.glob("spec/fixtures/*.compile.yml") do |file|
      content = YAML.load_file file
      file =~ /spec\/fixtures\/(.*)\.compile\.yml/

      it "compiles #{$1}" do
        expect(content["data"]).to compile.and_produce content["compiled"]
      end
    end
  end

  describe "invalid directives" do
    let(:scanner) do
      s = Liquidscript::Scanner::Liquidscript.new(
        ":[test thing]\n:[allow thing]\n")
      s.scan
      s
    end

    xit "raises an error" do
      expect { subject.compile }.to raise_error(Liquidscript::UnknownDirectiveError)
    end
  end

  describe "directives" do
    let(:scanner) do
      s = Liquidscript::Scanner::Liquidscript.new(":[allow test]\n")
      s.scan
      s
    end

    xit "raises an error" do
      subject.compile
      subject.top.context.get(:test)
    end
  end
end
