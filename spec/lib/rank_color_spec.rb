require 'spec_helper'

describe Imagga::RankColor do
  context "when initialized through rgb values" do
    subject { described_class.new(percent: 40, r: 200, g: 100, b: 50) } 

    it "has percent" do
      subject.percent.should == 40
    end

    it "has r value" do
      subject.r.should == 200
    end

    it "has g value" do
      subject.g.should == 100
    end

    it "has b value" do
      subject.b.should == 50
    end

    it "has hex value" do
      subject.hex.should == '#c86432'
    end
  end

  context "when initialized through hex value" do
    subject { described_class.new(percent: 40, hex: '#c86432') } 

    it "has percent" do
      subject.percent.should == 40
    end

    it "has r value" do
      subject.r.should == 200
    end

    it "has g value" do
      subject.g.should == 100
    end

    it "has b value" do
      subject.b.should == 50
    end

    it "has hex value" do
      subject.hex.should == '#c86432'
    end
  end
end
