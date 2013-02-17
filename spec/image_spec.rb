require 'spec_helper'
require 'imagga/image'

describe Imagga::Image do
  subject { described_class.new(url: 'http://', id: '1234') }
 
  it "has id" do
    subject.id.should == '1234'
  end 

  it "has url" do
    subject.url.should == 'http://'
  end 

  context "without url" do
    it "throws ArgumentError" do
      expect{ described_class.new(id: '1234') }.to raise_error(ArgumentError, 'url is missing')
    end
  end

  context "without id" do
    it "assigns id as 0" do
      described_class.new(url: 'http://').id.should == 0
    end
  end
end
