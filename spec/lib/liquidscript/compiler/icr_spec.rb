require "spec_helper"
require "yaml"

describe Compiler::ICR do

  let(:scanner) do
    iterator = double("iterator")
    scanner = double("scanner")

    expect(scanner).to receive(:each).once.and_return(iterator)
    allow(iterator).to receive(:next).and_return([
      Scanner::Token.new(:number, "32"),
      Scanner::Token.new(:number, "10")])
    allow(iterator).to receive(:peek).and_return(
      Scanner::Token.new(:number, "32"))
    allow(iterator).to receive(:rewind)
    scanner
  end

  subject do
    described_class.new(scanner)
  end

  describe "#peek" do
    specify { expect(subject.peek).to be_a Scanner::Token }
    specify { expect(subject.peek).to be_type :number }
  end

  describe "#expect" do

    context "with one argument" do
      before do
        expect(subject).to receive(:compile_number).once
      end

      it "calls the corresponding method" do
        subject.expect :number
      end
    end

    context "with a mismatching argument" do
      it "raises an error" do
        expect {
          subject.expect :string
        }.to raise_error CompileError
      end
    end

    context "with a hash argument" do
      let :probe do
        block = lambda {}

        expect(block).to receive(:arity).once.and_return(0)
        expect(block).to receive(:call).once.with(no_args)
        block
      end

      let :bad_probe do
        block = lambda {}

        expect(block).to_not receive(:arity)
        expect(block).to_not receive(:call)
      end

      context "and a symbol value" do
        before do
          expect(subject).to receive(:compile_something).once
        end

        it "calls the corresponding method" do
          subject.expect :number => :something
        end
      end

      context "and a block value" do

        it "calls the corresponding block" do
          subject.expect :number => probe
        end
      end

      context "with no right action" do
        it "raises an error" do
          expect {
            subject.expect :string => :foo
          }.to raise_error CompileError
        end

        it "uses the catch all" do
          subject.expect :string => bad_probe,
            :_ => probe
        end
      end
    end

  end

  describe "#compile" do
    specify {
      expect("hello = 3").to compile.and_produce([
        [:_context, [:hello]], [:set, [:_variable, :hello], [:number, "3"]]
      ])
    }

    specify {
      expect("{hello: 'world}").to compile.and_produce([
        [:_context, []], [:object, [[[:identifier, "hello"], [:sstring, "world"]]]]
      ])
    }

    specify {
      expect("(test)-> { 2 }").to compile.and_produce([
        [:_context, []], [:function,
          [
            [:_context, [:test]],
            [:_arguments, [[:identifier, "test"]]],
            [:number, "2"]
          ]
      ]])
    }

    specify { expect("(2)").to compile         }
    specify { expect("(2)->").to_not compile   }
    specify { expect("()-> {}").to compile     }
    specify { expect("(test)-> {}").to compile }
    specify { expect("(test, foo)-> {}").to compile }
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
end
