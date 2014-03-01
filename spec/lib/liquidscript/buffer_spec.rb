require "spec_helper"

describe Liquidscript::Buffer do

  subject { described_class.new "hello ", "world" }

  its(:to_s) { should eq "hello world" }
  its(:inspect) { should eq '"hello world"' }

  it "appends a value" do
    subject.append(", test")
    expect(subject.to_s).to eq "hello world, test"
  end
end
