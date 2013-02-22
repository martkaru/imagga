require 'spec_helper'

describe Imagga::ImageInfo do

  let(:init_hash) { {
    "url" => 'http://image',
    "info" => {
      "image_colors" => [ { "html_code" => "#676262", } ],
      "foreground_colors" => [ { "html_code" => "#c7322b", } ],
      "background_colors" => [ { "html_code" => "#676161", } ],
      "object_percentage" => 17.99,
      "color_variance" => "37",
      "image_packed" => nil,
      "foreground_packed" => nil,
      "background_packed" => nil
    }
  } }
  subject { described_class.new(init_hash) }

  describe "initialized by hash" do

    it "has url" do
      subject.url.should == 'http://image'
    end

    it "has image colors" do
      subject.image_colors.should have(1).items
      subject.image_colors.first.html_code.should == '#676262'
    end

    it "has foreground colors" do
      subject.foreground_colors.should have(1).items
      subject.foreground_colors.first.html_code.should == '#c7322b'
    end

    it "has background colors" do
      subject.background_colors.should have(1).items
      subject.background_colors.first.html_code.should == '#676161'
    end

    it "has object percentage" do
      subject.object_percentage.should == 17.99
    end

    it "has color variance" do
      subject.color_variance.should == 37
    end
  end

  describe "initialized by hash with not supported attributes" do
    subject { described_class.new(a: 'b') }

    it "ignores not supported attributes" do
      expect { subject.a }.to raise_error
    end
  end

  describe "initialied with empty color info" do
    let(:init_hash) { {
      "url" => 'http://image',
      "info" => {
        "image_colors" => [],
        "foreground_colors" => [],
        "background_colors" => [],
      }
    } }

    it "initializes color infos as empty arrays" do
      subject.image_colors.should be_empty
      subject.foreground_colors.should be_empty
      subject.background_colors.should be_empty
    end
  end

  describe "initialied with missing color info" do
    let(:init_hash) { {
      "url" => 'http://image',
      "info" => {}
    } }

    it "does not initialize color infos" do
      subject.image_colors.should be_nil
      subject.foreground_colors.should be_nil
      subject.background_colors.should be_nil
    end
  end

end
