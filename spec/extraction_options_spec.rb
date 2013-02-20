require 'spec_helper'

describe Imagga::ExtractOptions do
  subject { described_class.new('apikey', 'secret') }

  describe "#options" do
    it "builds simple options" do
      subject.options('http://image').should == {
        urls: 'http://image',
        method: 'imagga.colorsearch.extract',
        sig: '76e667179a6520da86e272a609bc7fab',
        api_key: 'apikey',
        v: '1.0'
      }
    end

    it "builds complex options" do
      subject.options([
        Imagga::Image.new(url: 'http://image1', id: '333'),
        Imagga::Image.new(url: 'http://image2')
      ], extract_overall_colors: true, extract_object_colors: false).should == {
        urls: 'http://image1,http://image2',
        ids: '333,0',
        method: 'imagga.colorsearch.extract',
        extract_overall_colors: 1,
        extract_object_colors: 0,
        sig: 'd66a0e3409ed08878ce7efae2827de87',
        api_key: 'apikey',
        v: '1.0'
      }
    end
  end

  describe "#build_urls" do
    it "builds string of urls based on single image url string" do
      subject.build_urls('http://image').should == 'http://image'
    end

    it "builds string of urls based on image url string arrays" do
      subject.build_urls(['http://image1', 'http://image2']).should == 'http://image1,http://image2'
    end

    it "builds string of urls based on single image object" do
      subject.build_urls(Imagga::Image.new(url: 'http://image')).should == 'http://image'
    end

    it "builds string of urls based on image object array" do
      subject.build_urls([
        Imagga::Image.new(url: 'http://image1'),
        Imagga::Image.new(url: 'http://image2')]).should == 'http://image1,http://image2'
    end
  end

  describe "#build_ids" do
    it "returns 0 based on single image url string" do
      subject.build_ids('http://image').should == nil
    end

    it "returns array of 0-s given image url string arrays" do
      subject.build_ids(['http://image1', 'http://image2']).should == nil
    end

    it "builds string of ids based on single image object" do
      subject.build_ids(Imagga::Image.new(url: 'http://image', id: '123')).should == '123'
    end

    it "builds string of ids based on image object array" do
      subject.build_ids([
        Imagga::Image.new(url: 'http://image1', id: '123'),
        Imagga::Image.new(url: 'http://image2')]).should == '123,0'
    end
  end
end
