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
