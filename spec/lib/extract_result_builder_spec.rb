require 'spec_helper'

describe Imagga::ExtractResultBuilder do
  let(:result) { {
      "colors" => [
        {
          "url" =>"http:\/\/www.stockpodium.com\/stock-photo-8244245\/smiling-presenting-2-apples-image.jpg",
          "info" => {}
        },
        {
          "url" =>"http:\/\/www.stockpodium.com\/stock-photo-9289532\/car-dirving-very-fast-under-image.jpg",
          "info" => {}
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
