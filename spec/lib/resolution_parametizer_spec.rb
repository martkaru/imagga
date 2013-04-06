require 'spec_helper'

describe Imagga::ResolutionParametizer do
  subject { described_class.new }

  describe "#parametrize" do
    it "creates a resolutions parameter for the service" do
      subject.parametrize('123x342').should == { resolutions: '123,342' }
    end
  end

  describe "#build_resolutions" do
    it "produces empty string from nil input" do
      subject.build_resolutions(nil).should ==  ''
    end

    it "produces empty string from empty string input" do
      subject.build_resolutions('').should ==  ''
    end

    it "produces empty string from empty array" do
      subject.build_resolutions([]).should ==  ''
    end

    it "produces comma separated string from single a x b resolution string" do
      subject.build_resolutions('123x234').should ==  '123,234'
    end

    it "produces comma separated string from many a x b resolutions in one string" do
      subject.build_resolutions('123x234,90x33,432x88').should ==  '123,234,90,33,432,88'
    end

    it "leaves comma seperated resolution as is" do
      subject.build_resolutions('123,234').should ==  '123,234'
    end

    it "produces comma separated string from single element a x b resolution array" do
      subject.build_resolutions(['123x234']).should ==  '123,234'
    end

    it "produces comma separated string from many a x b resolutions in one array" do
      subject.build_resolutions(['123x234','90x33','432x88']).should ==  '123,234,90,33,432,88'
    end

    it "produces comma separated string from mixed format array" do
      subject.build_resolutions(['123x234,90,33','432x88']).should ==  '123,234,90,33,432,88'
    end
  end

  describe "#build_resolution_string" do
    it "translates a x b resolution form to comma seperated string" do
      subject.build_resolution_string('123x234').should ==  '123,234'
    end

    it "leaves comma seperated resolution as is" do
      subject.build_resolution_string('123,234').should ==  '123,234'
    end
  end
end

