require 'spec_helper'
require 'fake_web'

describe "Image info extraction service" do

  let(:base_uri)         { 'http://example.com' }
  let(:image_url)        { 'http://image' }
  let(:fake_service_url) { 'http://example.com/colorsearchserver.php' }
  let(:extract_response) { IO.read('./spec/fixtures/extract_response.txt') }
  let(:failed_signature_response) { '{"error_code":3,"error_message":"Invalid signature"}' }
  subject { Imagga::Client.new(api_key: '123456', api_secret: 'secret', base_uri: base_uri) }

  context "with successful request" do
    before do
      FakeWeb.register_uri(:post, fake_service_url, body: extract_response)
    end

    it "extracts image info" do
      subject.extract(image_url).size.should == 2
    end
  end

  context "with failing request" do
    before do
      FakeWeb.register_uri(:post, fake_service_url, body: failed_signature_response)
    end

    it "raises exception" do
      expect { subject.extract(image_url) }.to raise_error(Imagga::ClientException)
    end

    context "exception" do
      before do
        begin
          subject.extract(image_url)
        rescue Imagga::ClientException => e
          @exception = e
        end
      end

      it "has message" do
        @exception.message.should == 'Invalid signature'
      end

      it "has error code" do
        @exception.error_code.should == 3
      end
    end
  end
end
