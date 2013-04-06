require 'spec_helper'

describe Imagga::ImageCrop do
  subject { described_class.new(
    'target_width' =>  10,
    'target_height' => 22,
    'x1' => 33, 'y1' => 44,
    'x2' => 55, 'y2' => 66
  ) }

  it "has target_widht" do
    subject.target_width.should == 10
  end

  it "has target height" do
    subject.target_height.should == 22
  end

  it "has x1 and y1" do
    subject.x1.should == 33
    subject.y1.should == 44
  end

  it "has x2 and y2" do
    subject.x2.should == 55
    subject.y2.should == 66
  end

  describe "#info" do
    it 'returns infor string about the crop suggestions' do
      subject.info.should == 'target: (10,22), crop: (33, 44) to (55, 66)' 
    end
  end
end
