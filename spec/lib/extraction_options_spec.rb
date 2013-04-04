require 'spec_helper'

describe Imagga::ExtractOptions do

  subject { described_class.new('apikey', 'secret') }

  describe "#options" do

    it "builds simple options" do
      subject.options(urls: 'http://image').should == {
        urls:    'http://image',
        method:  'imagga.colorsearch.extract',
        sig:     '76e667179a6520da86e272a609bc7fab',
        api_key: 'apikey',
        v:       '1.0'
      }
    end

    it "builds complex options" do
      subject.options(
        urls: 'http://image1,http://image2',
        ids:  '333,0',
        extract_overall_colors: true,
        extract_object_colors:  false
      ).should == {
        urls:   'http://image1,http://image2',
        ids:    '333,0',
        method: 'imagga.colorsearch.extract',
        extract_overall_colors: 1,
        extract_object_colors:  0,
        sig:     'd66a0e3409ed08878ce7efae2827de87',
        api_key: 'apikey',
        v: '1.0'
      }

    end
  end
end
