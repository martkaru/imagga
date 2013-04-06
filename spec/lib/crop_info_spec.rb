require 'spec_helper'

describe Imagga::CropInfo do
  let(:crop_info) { JSON.parse(IO.read('./spec/fixtures/crop_response.txt')) }
  subject { described_class.new(crop_info['smart_croppings'].first) }

  it "has url" do
    subject.url.should == 'http://www.stockpodium.com/stock-photo-7890736/couple-child-spending-time-together-image.jpg'
  end

  it "has croppings" do
    subject.croppings.size.should == 3
    subject.croppings.first.x2.should == 355
  end
end
