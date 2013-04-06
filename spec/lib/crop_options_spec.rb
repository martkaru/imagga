require 'spec_helper'

describe Imagga::CropOptions do
  subject { described_class.new('apikey', 'secret') }

  describe "#options" do
    it "builds simple options" do
      subject.options(
        urls: 'http://image',
        resolutions: '100x40,50x100',
        no_scaling: true
      ).should == {
        api_key:     "apikey",
        method:      "imagga.process.crop",
        no_scaling:  1,
        resolutions: "100x40,50x100",
        sig:         "dde5487ab116f710402d7821a241389a",
        urls:        "http://image",
        v:           "1.0"
      }
    end

  end
end
