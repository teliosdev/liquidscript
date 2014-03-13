require "spec_helper"

describe Liquidscript::Scanner do
  subject { described_class::Liquidscript.new("42") }
  it { should be_a Enumerable }

  describe "#each" do
    specify { expect(subject.each).to be_a Enumerator }
    specify { expect { |y| subject.each(&y) }.to yield_control.once }
  end

  context "with invalid input" do
    subject { described_class::Liquidscript.new("';") }

    it "raises an error" do
      expect {
        subject.each
      }.to raise_error Liquidscript::SyntaxError
    end
  end
end
