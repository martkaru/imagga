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

Set up client

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


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
