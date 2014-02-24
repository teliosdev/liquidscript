require "spec_helper"

describe Liquidscript::Scanner do
  subject { described_class.new("42") }
  it { should be_a Enumerable }

  describe "#each" do
    specify { expect(subject.each).to be_a Enumerator }
    specify { expect { |y| subject.each(&y) }.to yield_control.once }
  end
end
