require 'spec_helper'
require 'fake_web'

describe Imagga::Client do

  subject { described_class.new(api_key: '1', api_secret: '2', base_uri: 'http://example.com') }
  let(:extract_response) {'{
    "colors":[
      {
        "url":"http:\/\/www.stockpodium.com\/stock-photo-8244245\/smiling-presenting-2-apples-image.jpg",
        "info":{
          "image_colors":[
            {
              "percent":"38.90",
              "r":"247",
              "g":"245",
              "b":"243",
              "html_code":"#f7f5f3",
              "closest_palette_color":"white",
              "closest_palette_color_parent":"white",
              "closest_palette_distance":1.8304102578
            },
            {
              "percent":"35.16",
              "r":"206",
              "g":"167",
              "b":"146",
              "html_code":"#cea792",
              "closest_palette_color":"fresco",
              "closest_palette_color_parent":"beige",
              "closest_palette_distance":4.93287465177
            },
            {
              "percent":"10.41",
              "r":"150",
              "g":"60",
              "b":"45",
              "html_code":"#963c2d",
              "closest_palette_color":"ribbon red",
              "closest_palette_color_parent":"red",
              "closest_palette_distance":5.6423821179
            },
            {
              "percent":"8.38",
              "r":"55",
              "g":"37",
              "b":"31",
              "html_code":"#37251f",
              "closest_palette_color":"espresso",
              "closest_palette_color_parent":"brown",
              "closest_palette_distance":5.91329502182
            },
            {
              "percent":"7.15",
              "r":"168",
              "g":"181",
              "b":"45",
              "html_code":"#a8b52d",
              "closest_palette_color":"mint",
              "closest_palette_color_parent":"olive green",
              "closest_palette_distance":10.7126507469
            }
          ],
          "foreground_colors":[
            {
              "percent":"45.92",
              "r":"200",
              "g":"180",
              "b":"112",
              "html_code":"#c8b470",
              "closest_palette_color":"medium olive",
              "closest_palette_color_parent":"skin",
              "closest_palette_distance":7.22056402093
            },
            {
              "percent":"34.21",
              "r":"162",
              "g":"79",
              "b":"61",
              "html_code":"#a24f3d",
              "closest_palette_color":"fiesta",
              "closest_palette_color_parent":"red",
              "closest_palette_distance":6.29194294147
            },
            {
              "percent":"19.86",
              "r":"52",
              "g":"35",
              "b":"31",
              "html_code":"#34231f",
              "closest_palette_color":"espresso",
              "closest_palette_color_parent":"brown",
              "closest_palette_distance":6.49089812519
            }
          ],
          "background_colors":[
            {
              "percent":"58.05",
              "r":"249",
              "g":"248",
              "b":"247",
              "html_code":"#f9f8f7",
              "closest_palette_color":"white",
              "closest_palette_color_parent":"white",
              "closest_palette_distance":2.48109615666
            },
            {
              "percent":"36.41",
              "r":"206",
              "g":"177",
              "b":"161",
              "html_code":"#ceb1a1",
              "closest_palette_color":"pearl pink",
              "closest_palette_color_parent":"light pink",
              "closest_palette_distance":4.11506425614
            },
            {
              "percent":"5.55",
              "r":"150",
              "g":"100",
              "b":"77",
              "html_code":"#96644d",
              "closest_palette_color":"light bronze",
              "closest_palette_color_parent":"skin",
              "closest_palette_distance":6.37479340147
            }
          ],
          "object_percentage":38.4,
          "color_variance":"33"
        }
      },
      {
        "url":"http:\/\/www.stockpodium.com\/stock-photo-9289532\/car-dirving-very-fast-under-image.jpg",
        "info":{
          "image_colors":[
            {
              "percent":"38.53",
              "r":"103",
              "g":"98",
              "b":"98",
              "html_code":"#676262",
              "closest_palette_color":"blue steel",
              "closest_palette_color_parent":"grey",
              "closest_palette_distance":10.486937593
            },
            {
              "percent":"26.31",
              "r":"42",
              "g":"37",
              "b":"33",
              "html_code":"#2a2521",
              "closest_palette_color":"espresso",
              "closest_palette_color_parent":"brown",
              "closest_palette_distance":8.14492880108
            },
            {
              "percent":"16.19",
              "r":"178",
              "g":"182",
              "b":"190",
              "html_code":"#b2b6be",
              "closest_palette_color":"frost",
              "closest_palette_color_parent":"light grey",
              "closest_palette_distance":2.82095071372
            },
            {
              "percent":"12.06",
              "r":"197",
              "g":"51",
              "b":"45",
              "html_code":"#c5332d",
              "closest_palette_color":"fiesta",
              "closest_palette_color_parent":"red",
              "closest_palette_distance":5.41278686601
            },
            {
              "percent":"6.91",
              "r":"86",
              "g":"97",
              "b":"28",
              "html_code":"#56611c",
              "closest_palette_color":"moss",
              "closest_palette_color_parent":"olive green",
              "closest_palette_distance":9.97695248255
            }
          ],
          "foreground_colors":[
            {
              "percent":"62.98",
              "r":"199",
              "g":"50",
              "b":"43",
              "html_code":"#c7322b",
              "closest_palette_color":"fiesta",
              "closest_palette_color_parent":"red",
              "closest_palette_distance":5.44027296941
            },
            {
              "percent":"22.01",
              "r":"140",
              "g":"132",
              "b":"144",
              "html_code":"#8c8490",
              "closest_palette_color":"shadow",
              "closest_palette_color_parent":"light grey",
              "closest_palette_distance":3.40761167276
            },
            {
              "percent":"15.01",
              "r":"61",
              "g":"38",
              "b":"43",
              "html_code":"#3d262b",
              "closest_palette_color":"espresso",
              "closest_palette_color_parent":"brown",
              "closest_palette_distance":5.85441000013
            }
          ],
          "background_colors":[
            {
              "percent":"41.07",
              "r":"103",
              "g":"97",
              "b":"97",
              "html_code":"#676161",
              "closest_palette_color":"blue steel",
              "closest_palette_color_parent":"grey",
              "closest_palette_distance":10.6345471176
            },
            {
              "percent":"39.63",
              "r":"53",
              "g":"51",
              "b":"34",
              "html_code":"#353322",
              "closest_palette_color":"graphite",
              "closest_palette_color_parent":"black",
              "closest_palette_distance":9.18317865786
            },
            {
              "percent":"19.29",
              "r":"174",
              "g":"180",
              "b":"187",
              "html_code":"#aeb4bb",
              "closest_palette_color":"frost",
              "closest_palette_color_parent":"light grey",
              "closest_palette_distance":2.03931376316
            }
          ],
          "object_percentage":17.99,
          "color_variance":"37",
          "image_packed":null,
          "foreground_packed":null,
          "background_packed":null
        }
      }
    ]
  }'}

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

  it "has api_key" do
    subject.api_key.should == '1'
  end

  it "has api_secret" do
    subject.api_secret.should == '2'
  end

  it "has base_uri" do
    subject.base_uri.should == 'http://example.com'
  end

  it "knows service path" do
    subject.service_path.should == '/colorsearchserver.php'
  end

  describe "#extract" do
    it "extracts image info" do
      FakeWeb.register_uri(:post, 'http://example.com/colorsearchserver.php', body: extract_response)
      subject.extract('http://image').size.should == 2
    end

    context "with failing request" do
      before :each do
        FakeWeb.register_uri(:post, 'http://example.com/colorsearchserver.php', body: failed_signature_response)
        subject.should_receive(:extract_options).with('http://image', {})
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

  describe "#rank" do
    let(:rank_arguments) { {
      color_vector: [{percent: 60, r: 255, g: 0, b: 0}],
      type: 'overall',
      dist: 3000,
      count: 200
    } }

    it "does a rank search" do
      FakeWeb.register_uri(:post, 'http://example.com/colorsearchserver.php', body: rank_response)
      subject.rank(rank_arguments).size.should == 2
    end

    context "with failing request" do
      before :each do
        FakeWeb.register_uri(:post, 'http://example.com/colorsearchserver.php', body: failed_signature_response)
        subject.should_receive(:rank_options)
      end

      it "raises exception" do
        expect { subject.rank(rank_arguments) }.to raise_error(Imagga::ClientException)
      end

      it "populates exception object with details" do
        begin
          subject.rank(rank_arguments)
        rescue Imagga::ClientException => e
          e.message.should == 'Invalid signature'
          e.error_code.should == 3
        end
      end
    end
  end
end
