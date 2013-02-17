require 'spec_helper'

describe Imagga::Client do

  subject { described_class.new(api_key: '1', api_secret: '2', base_uri: 'http://example.com') }

  it "has api_key" do
    subject.api_key.should == '1'
  end

  it "has api_secret" do
    subject.api_secret.should == '2'
  end

  it "has base_uri" do
    subject.base_uri.should == 'http://example.com'
  end

  it "implements version 1" do
    subject.version.should == '1.0'
  end

  it "knows extract service path" do
    subject.extract_service_path.should == '/colorsearchserver.php'
  end

  describe "#extract" do
    it "extracts image info" do
      Imagga::Client.should_receive(:post).with(
        '/colorsearchserver.php', body: { a: :b}
      ) { '["result"]' }
      subject.should_receive(:extract_options).with('http://image', {}) { { a: :b } }
      subject.extract('http://image').should == ['result']
    end

    context "with failing request" do
      before :each do
        Imagga::Client.should_receive(:post).with(
          '/colorsearchserver.php',
          body: { a: :b}
        ) { '{"error_code":3,"error_message":"Invalid signature"}' }
        subject.should_receive(:extract_options).with('http://image', {}) { { a: :b } }
      end

      it "raises exception" do
        expect { subject.extract('http://image') }.to raise_error(Imagga::ClientException)
      end

      it "populates exception object with details" do
        begin
          subject.extract('http://image')
        rescue Imagga::ClientException => e
          e.message.should == 'Invalid signature'
          e.error_code.should == 3
        end
      end
    end
  end
end
