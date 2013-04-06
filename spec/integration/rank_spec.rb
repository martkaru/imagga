require 'spec_helper'
require 'fake_web'

describe "Multicolor search" do

  let(:base_uri)         { 'http://example.com' }
  let(:fake_service_url) { 'http://example.com/colorsearchserver.php' }
  let(:rank_response)    { IO.read('./spec/fixtures/rank_response.txt') }
  let(:failed_signature_response) { '{"error_code":3,"error_message":"Invalid signature"}' }

  subject { Imagga::Client.new(api_key: '123456', api_secret: 'secret', base_uri: base_uri) }

  context "with successful request" do
    before do
      FakeWeb.register_uri(:post, fake_service_url, body: rank_response)
    end

    it "searches images by color" do
      subject.rank(
        colors: [
          Imagga::RankColor.new(percent: 60, r: 10, g: 20, b: 30),
          Imagga::RankColor.new(percent: 20, hex: '#ff00ff'),
          '39,12,34,123'
        ],
          type: :overall,
          dist: 3000,
          count: 10
      ).size.should == 2
    end
  end

  context "with missing colors in params" do
    it "throws an error" do
      expect {
        subject.rank(
          type: :overall,
          dist: 3000,
          count: 10
        ) }.to raise_error(ArgumentError, 'colors is missing')
    end
  end

  context "with missing colors in params" do
    it "throws an error" do
      expect {
        subject.rank(
          colors: [
            Imagga::RankColor.new(percent: 60, r: 10, g: 20, b: 30),
            Imagga::RankColor.new(percent: 20, hex: '#ff00ff'),
            '39,12,34,123'
          ],
            dist: 3000,
            count: 10
        ) }.to raise_error(ArgumentError, 'type is missing')
    end
  end

  context "with failing request" do
    before do
      FakeWeb.register_uri(:post, fake_service_url, body: failed_signature_response)
    end

    it "raises exception" do
      expect { subject.rank(
        colors: [
          Imagga::RankColor.new(percent: 60, r: 10, g: 20, b: 30),
          Imagga::RankColor.new(percent: 20, hex: '#ff00ff'),
          '39,12,34,123'
        ],
          type: :overall,
          dist: 3000,
          count: 10
      ) }.to raise_error(Imagga::ClientException)
    end

    context "exception" do
      before do
        begin
          subject.rank(
            colors: [
              Imagga::RankColor.new(percent: 60, r: 10, g: 20, b: 30),
              Imagga::RankColor.new(percent: 20, hex: '#ff00ff'),
              '39,12,34,123'
            ],
              type: :overall,
              dist: 3000,
              count: 10
          )
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
