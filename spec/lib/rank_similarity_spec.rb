require 'spec_helper'

describe Imagga::RankSimilarity do

  let(:init_hash) { {
    "id" => 8774077,
    "dist" => 2597.38299
  } }

  describe "initialized by hash" do
    subject { described_class.new(init_hash) }

    it "has id" do
      subject.id.should == 8774077
    end

    it "has dist" do
      subject.dist.should == 2597.38299
    end
  end

  # todo
  describe "initialized by hash with not supported attributes" do
    subject { described_class.new(a: 'b') }

    it "ignores not supported attributes" do
      expect { subject.a }.to raise_error
    end
  end

end
