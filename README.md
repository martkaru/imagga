[![Code Climate](https://codeclimate.com/github/martkaru/imagga.png)](https://codeclimate.com/github/martkaru/imagga)
[![Build Status](https://travis-ci.org/martkaru/imagga.png?branch=master)](https://travis-ci.org/martkaru/imagga)

# Imagga

Client for Imagga image analytics services API

## Installation

Add this line to your application's Gemfile:

    gem 'imagga'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install imagga

## Usage

Set up a client

    client = Imagga::Client.new(
      base_uri:   '0.0.0.0',                # IP of the Imagga server
      api_key:    '12345678',               # Your api key
      api_secret: '1234567890123456789'     # Your api secret
    )

Extract image information

    results = client.extract('http://imagga.com/images/scheme_colors.png')


Extract image information with indexing and extraction options:

    results = client.extract(
      [
        Imagga::Image.new(url: 'http://image1', id: '333'),
        Imagga::Image.new(url: 'http://image2')
      ],
      extract_overall_colors: true,
      extract_object_colors: false
    )

Check the results, for example:

    results.each do |info|                   # iterate over all input image infos
      puts info.object_percentage            # percentage of the central object on image
      info.image_colors.each do |color|      # iterate over all significant colors
        puts color.info                      # 85.89%, rgb: (246,246,246), hex: #f6f6f6 
      end
    end

Multi-color search:

    client.rank(
      colors: [
        Imagga::RankColor.new(percent: 100, r: 82, g: 37, b: 43)   # use r g b values
        Imagga::RankColor.new(percent: 100, hex: '#336699')        # or use hex
      ],
      type: 'object',
      dist: 6000,
      count: 10
    ).each do |similarity|
      puts "Distance of #%i is %.4f" % [similarity.id, similarity.dist]  # Distance of #333 is 3581.5500
    end

Image crop suggestions:

    client.crop(
      [
        'http://image1',                        # Use urls
        Imagga::Image.new(url: 'http://image2') # or image object
      ],
      resolutions: ['100x40','50x100'],         # '100,40,50,100' or '100x40,50x100' instead of array would work also
      no_scaling: true
    ).each do |crop_info|
      puts crop_info.url
      crop_info.croppings.each do |cropping|
        puts cropping.info
      end
    end

## Contributors

martkaru

jprosevear


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
