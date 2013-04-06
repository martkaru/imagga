require 'spec_helper'

describe Imagga::ImageOrUrlParametizer do
  subject { described_class.new }

  describe "#parametrize" do
    it "builds string of urls based on single image url string" do
      subject.parametrize('http://image').should == { urls: 'http://image' }
    end

    it "builds string of urls based on image url string arrays" do
      subject.parametrize(['http://image1', 'http://image2']).should == { urls: 'http://image1,http://image2' }
    end

    it "builds string of urls based on single image object" do
      subject.parametrize(Imagga::Image.new(url: 'http://image', id: '99')).should == { urls: 'http://image', ids: '99' }
    end

    it "builds string of urls based on image object array" do
      subject.parametrize([
        Imagga::Image.new(url: 'http://image1', id: '333'),
        Imagga::Image.new(url: 'http://image2')]).should == { urls: 'http://image1,http://image2', ids: '333,0' }
    end
  end

  describe "#build_urls" do
    it "builds string of urls based on single image url string" do
      subject.build_urls('http://image').should == { urls: 'http://image' }
    end

    it "builds string of urls based on image url string arrays" do
      subject.build_urls(['http://image1', 'http://image2']).should == { urls: 'http://image1,http://image2' }
    end

    it "builds string of urls based on single image object" do
      subject.build_urls(Imagga::Image.new(url: 'http://image')).should == { urls: 'http://image' }
    end

    it "builds string of urls based on image object array" do
      subject.build_urls([
        Imagga::Image.new(url: 'http://image1'),
        Imagga::Image.new(url: 'http://image2')]).should == { urls: 'http://image1,http://image2' }
    end
  end

  describe "#build_comma_separated_string" do
    it "returns 0 based on single image url string" do
      subject.build_ids('http://image').should == { ids: nil }
    end

    it "returns array of 0-s given image url string arrays" do
      subject.build_ids(['http://image1', 'http://image2']).should == { ids: nil }
    end

    it "builds string of ids based on single image object" do
      subject.build_ids(Imagga::Image.new(url: 'http://image', id: '123')).should == { ids: '123' }
    end

    it "builds string of ids based on image object array" do
      subject.build_ids([
        Imagga::Image.new(url: 'http://image1', id: '123'),
        Imagga::Image.new(url: 'http://image2')]).should == { ids: '123,0' } 
    end
  end
end
