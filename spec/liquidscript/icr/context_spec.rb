require "spec_helper"

include Liquidscript

describe ICR::Context do

  it "creates a variable" do
    expect(subject.set(:test)).to be_a ICR::Variable
  end

  it "gives an invalid reference" do
    expect {
      subject.get(:test)
    }.to raise_error Liquidscript::InvalidReferenceError
  end

  context "with a parent" do

    let(:parent) do
      parent = double("parent")
      expect(parent).to receive(:get).once.with(:foo).and_return(:test)
      parent
    end

    subject do
      context = ICR::Context.new
      context.parents << parent
      context
    end

    it "retrives the variable" do
      expect(subject.get(:foo)).to be :test
    end

  end
end
