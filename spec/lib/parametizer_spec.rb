require 'spec_helper'

class DummyParametizer; include Imagga::Parametizer; end

describe Imagga::Parametizer do
  subject { DummyParametizer.new }

  describe "#build_comma_separated_string" do
    it "builds list of object fields" do
      object = stub(field: 'asdf')
      subject.build_comma_separated_string([object]*2, :field).should == 'asdf,asdf'
    end

    it "defaults to default value, if field is not present" do
      object = Object.new
      object2 = stub(field: 'asdf')
      subject.build_comma_separated_string([object, object2], :field, 'qwer').should == 'qwer,asdf'
    end

    it "produces no result if all items default to the default value" do
      object = Object.new
      subject.build_comma_separated_string([object]*3, :field, 'qwer').should == nil
    end
  end

  describe "#build_boolean_options" do
    it "produces hash with boolean values coded as 1 and 0" do
      input = { foo: true, boo: false }
      subject.build_boolean_options(input, [:foo, :boo]).should ==  { foo: 1, boo: 0 }
    end

    it "produces hash with initial boolean values '1' and '0' coded as 1 and 0" do
      input = { foo: '1', boo: '0' }
      subject.build_boolean_options(input, [:foo, :boo]).should ==  { foo: 1, boo: 0 }
    end

    it "produces hash with initial boolean values 1 and 0 coded as 1 and 0" do
      input = { foo: 1, boo: 0 }
      subject.build_boolean_options(input, [:foo, :boo]).should ==  { foo: 1, boo: 0 }
    end
  end
end
