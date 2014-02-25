require "spec_helper"

describe Liquidscript::ICR::Set do

  its(:metadata) { should be_a Hash }
  
  describe "#to_a" do
    specify { expect(subject.to_a).to be_an Array }
    specify { expect(subject.to_a).to have(0).items }
    
    context "with metadata" do
      subject do
        set = Liquidscript::ICR::Set.new
        set.metadata.merge! :hello => "world"
        set
      end
      
      specify { expect(subject.to_a).to have(1).item }
      specify { expect(subject.to_a).to eq [[:_hello, "world"]] }
      
    end
    
    context "with codes" do
      subject do
        set = Liquidscript::ICR::Set.new
        set << "test"
        set
      end
      
      specify { expect(subject.to_a).to have(1).item }
      specify { expect(subject.to_a).to eq ["test"] }
      
    end
    
    context "with both" do
      subject do
        set = Liquidscript::ICR::Set.new
        set.metadata.merge! :hello => "world"
        set << "test"
        set
      end
      
      specify { expect(subject.to_a).to have(2).items }
      specify { expect(subject.to_a).to eq [[:_hello, "world"], "test"] }

    end
  end
end
