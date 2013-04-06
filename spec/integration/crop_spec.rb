require 'spec_helper'
require 'fake_web'

describe "Image crop suggestions" do

  let(:base_uri)         { 'http://example.com' }
  let(:image_url)        { 'http://image' }
  let(:fake_service_url) { 'http://example.com/extractionrestserver.php' }
  let(:crop_response)    { IO.read('./spec/fixtures/crop_response.txt') }
  let(:failed_signature_response) { '{"error_code":3,"error_message":"Invalid signature"}' }
  let(:params) { [
    [
      Imagga::Image.new(url: 'http://image1', id: '333'),
      Imagga::Image.new(url: 'http://image2')
    ],
      resolutions: ['100x50', '40x200'],
      no_scaling: true
    ]
  }

  subject { Imagga::Client.new(api_key: '123456', api_secret: 'secret', base_uri: base_uri) }

  context "with successful request" do
    before do
      FakeWeb.register_uri(:post, fake_service_url, body: crop_response)
    end

    it "produces image crop info" do
      subject.crop(*params).size.should == 2
    end
  end

  context "with failing request" do
    before do
      FakeWeb.register_uri(:post, fake_service_url, body: failed_signature_response)
    end

    it "raises exception" do
      expect { subject.crop(*params) }.to raise_error(Imagga::ClientException)
    end

    context "exception" do
      before do
        begin
          subject.crop(*params)
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
