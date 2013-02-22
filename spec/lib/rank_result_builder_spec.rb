require 'spec_helper'

describe Imagga::RankResultBuilder do
  let(:result) { {
    'rank_similarity' =>  [
      {
        "id" => 8774077,
        "dist" => 2597.38299
      },
      {
        "id" => 9085916,
        "dist" => 2681.33259
      }
    ]
  } }

  subject { described_class.new }

  describe '#build'  do
    it "builds result" do
      subject.build_from(result).size.should == 2
    end
  end

end
