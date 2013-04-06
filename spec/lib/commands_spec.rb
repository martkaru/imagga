require 'spec_helper'
require 'fake_web'

class DummyCommand < Imagga::BaseCommand
  def args(options); options.merge(c: :d); end
  def service_path; '/service.php'; end
end

describe Imagga::BaseCommand do
  subject { DummyCommand.new('123456', 'secret','http://example.com') }

  it "has api_key" do
    subject.api_key.should == '123456'
  end

  it "has api_secret" do
    subject.api_secret.should == 'secret'
  end

  it "has base_uri" do
    subject.base_uri.should == 'http://example.com'
  end

  it "has class base_uri" do
    subject.class.base_uri.should == 'http://example.com'
  end

  describe "#execute" do
    it "sends service request with params and gets and parses json result" do
      described_class.should_receive(:post).with('/service.php', body: { a: :b, c: :d }) { '{"f": "g"}' }
      subject.execute(a: :b).should == { 'f' => 'g' }
    end
  end
end

describe Imagga::ExtractCommand do
  subject { described_class.new('123456', 'secret','http://example.com') }

  it "has service_path" do
    subject.service_path.should == '/colorsearchserver.php'
  end

  it "produces service arguments" do
    subject.args(urls: 'http://image').should == {
      api_key: "123456",
      method: "imagga.colorsearch.extract",
      sig: "d53bcdf68257613e6a7a224fa4457616",
      urls: "http://image",
      v: "1.0"
    }
  end
end

describe Imagga::RankCommand do
  subject { described_class.new('123456', 'secret','http://example.com') }

  it "has service_path" do
    subject.service_path.should == '/colorsearchserver.php'
  end

  it "produces service arguments" do
    subject.args(
      color_vector: '60,255,0,0,40,0,255,0',
      type: 'overall',
      dist: 3000,
      count: 100
    ).should == {
      color_vector: "60,255,0,0,40,0,255,0",
      type: "overall",
      count: 100,
      dist: 3000,
      api_key: "123456",
      method: "imagga.colorsearch.rank",
      sig: "8e953591efe7d3210cecf8045accaea5",
      v: "1.0"
    }
  end
end

#describe Imagga::CropCommand do
  #subject { described_class.new('123456', 'secret','http://example.com') }

  #it "has service_path" do
    #subject.service_path.should == '/extractionrestserver.php'
  #end

  #it "produces service arguments" do
    #subject.args(
      #color_vector: '60,255,0,0,40,0,255,0',
      #type: 'overall',
      #dist: 3000,
      #count: 100
    #).should == {
      #color_vector: "60,255,0,0,40,0,255,0",
      #type: "overall",
      #count: 100,
      #dist: 3000,
      #api_key: "123456",
      #method: "imagga.colorsearch.rank",
      #sig: "8e953591efe7d3210cecf8045accaea5",
      #v: "1.0"
    #}
  #end
#end
