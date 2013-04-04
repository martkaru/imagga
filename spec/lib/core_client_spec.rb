require 'spec_helper'

describe Imagga::CoreClient do

  subject { described_class.new(api_key: '123456', api_secret: 'secret', base_uri: 'http://example.com') }

  it "has api_key" do
    subject.api_key.should == '123456'
  end

  it "has api_secret" do
    subject.api_secret.should == 'secret'
  end

  it "has base_uri" do
    subject.base_uri.should == 'http://example.com'
  end

  describe "#extract" do
    it "executes extract image info command" do
      executes_command(Imagga::ExtractCommand, :extract)
    end
  end

  describe "#rank" do
    it "executes rank image command" do
      executes_command(Imagga::RankCommand, :rank)
    end
  end

  describe "#crop" do
    it "executes crop image command" do
      executes_command(Imagga::CropCommand, :crop)
    end
  end

  def executes_command(command_class, method_name)
    command = mock
    command_class.should_receive(:new).with('123456', 'secret', 'http://example.com') { command }
    command.should_receive(:execute).with(a: :b) { 'result' }
    subject.send(method_name, a: :b).should == 'result'
  end
end
