require 'spec_helper'

describe Imagga::RankColorParametizer do
  subject { described_class.new }

  describe "#parametrize" do
    it "generates string presentation of the rank color object" do
      subject.parametrize(Imagga::RankColor.new(percent: 40, hex: '#123456')).should == { color_vector: '40,18,52,86' }
    end

    it "generates string presentation of many rank color objects" do
      subject.parametrize([
        Imagga::RankColor.new(percent: 40, hex: '#123456'),
        Imagga::RankColor.new(percent: 10, hex: '#23421e'),
        Imagga::RankColor.new(percent: 33, hex: '#09238f')
      ]).should == { color_vector: '40,18,52,86,10,35,66,30,33,9,35,143' }
    end

    it "does not change the given color vector string" do
      subject.parametrize([
        Imagga::RankColor.new(percent: 40, hex: '#123456'),
        '10,35,66,30',
        Imagga::RankColor.new(percent: 33, hex: '#09238f')
      ]).should == { color_vector: '40,18,52,86,10,35,66,30,33,9,35,143' }
    end
  end
end
