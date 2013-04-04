require 'spec_helper'

describe Imagga::Client do

  subject { described_class.new(api_key: '1', api_secret: '2', base_uri: 'http://example.com') }

  let(:rank_response) { '{
    "rank_similarity":[
      {
        "id":8774077,
        "dist":2597.38299
      },
      {
        "id":9085916,
        "dist":2681.33259
      }
    ]
  }'}

  let(:failed_signature_response) { '{"error_code":3,"error_message":"Invalid signature"}' }

  #describe "#extract" do
    #it "produces paramete" do
      #core_result = stub
      #result = stub
      #Imagga::ImageOrUrlParametizer.any_instance.should_receive(:parametrize).with('asdf') { { c: :d } }
      #Imagga::CoreClient.any_instance.should_receive(:extract).with(a: :b, c: :d) { core_result }
      #Imagga::ExtractResultBuilder.any_instance.should_receive(:build_from).with(core_result) { result }

      #subject.extract('asdf', {a: :b}).should == result
    #end
  #end

#  describe "#rank" do
    #let(:rank_arguments) { {
      #color_vector: [{percent: 60, r: 255, g: 0, b: 0}],
      #type: 'overall',
      #dist: 3000,
      #count: 200
    #} }

    #it "does a rank search" do
      #FakeWeb.register_uri(:post, 'http://example.com/colorsearchserver.php', body: rank_response)
      #subject.rank(rank_arguments).size.should == 2
    #end

    #context "with failing request" do
      #before :each do
        #FakeWeb.register_uri(:post, 'http://example.com/colorsearchserver.php', body: failed_signature_response)
        #subject.should_receive(:rank_options)
      #end

      #it "raises exception" do
        #expect { subject.rank(rank_arguments) }.to raise_error(Imagga::ClientException)
      #end

      #it "populates exception object with details" do
        #begin
          #subject.rank(rank_arguments)
        #rescue Imagga::ClientException => e
          #e.message.should == 'Invalid signature'
          #e.error_code.should == 3
        #end
      #end
    #end
#  end
end
