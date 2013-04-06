require 'spec_helper'

describe Imagga::RankResultBuilder do
  let(:result) { JSON.parse(IO.read('./spec/fixtures/rank_response.txt')) }

  subject { described_class.new }

  describe '#build'  do
    it "builds result" do
      subject.build_from(result).size.should == 2
    end
  end

end
