require 'spec_helper'

describe Imagga::RankOptions do
  subject { described_class.new('apikey', 'secret') }

  describe "#options" do

    it "builds options" do
      subject.options(
        color_vector:  '49,33,44,55,11,22,33,44',
        urls:           'http://image',
        type:           :object,
        dist:           3000,
        count:          10
      ).should == {
        api_key:      'apikey',
        color_vector: '49,33,44,55,11,22,33,44',
        count:        '10',
        dist:         '3000',
        method:       'imagga.colorsearch.rank',
        sig:          '96185035e02a781a7b3455eb500eeec9',
        type:         'object',
        urls:         'http://image',
        v:            '1.0'
      }
    end
  end
end
