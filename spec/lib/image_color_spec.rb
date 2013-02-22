require 'spec_helper'

describe Imagga::ImageColor do

  let(:init_hash) { {
    "percent" => '19.29',
    "r" => '174', "g" => '180', "b" => '187',
    "html_code" => "#aeb4bb",
    "closest_palette_color" => "frost",
    "closest_palette_color_parent" => "light grey",
    "closest_palette_distance" => 2.03931376316
  } }

  describe "initialized by hash" do
    subject { described_class.new(init_hash) }

    it "has percent" do
      subject.percent.should == 19.29
    end

    it "has r" do
      subject.r.should == 174
    end

    it "has g" do
      subject.g.should == 180
    end

    it "has b" do
      subject.b.should == 187
    end

    it "has html_code" do
      subject.html_code.should == '#aeb4bb'
    end

    it "has closest palette color" do
      subject.closest_palette_color.should == 'frost'
    end

    it "has closest parent palette color" do
      subject.closest_palette_color_parent.should == 'light grey'
    end

    it "has closest palette distance" do
      subject.closest_palette_distance.should == 2.03931376316
    end
  end

  describe "initialized by hash with not supported attributes" do
    subject { described_class.new(a: 'b') }

    it "ignores not supported attributes" do
      expect { subject.a }.to raise_error
    end
  end

end
