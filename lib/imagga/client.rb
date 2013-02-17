require "httparty"
require "json"

module Imagga
  class Client
    include HTTParty
    include Imagga::Exceptions
    attr_reader :api_key, :api_secret, :base_uri, :version, :extract_service_path

    def initialize(opts={})
      @api_key    = opts[:api_key]    || raise_missing(:api_key)
      @api_secret = opts[:api_secret] || raise_missing(:api_secret)
      @base_uri   = opts[:base_uri]   || raise_missing(:base_uri)
      @version    = '1.0'
      @extract_service_path = '/colorsearchserver.php'

      Imagga::Client.base_uri @base_uri
    end

    def extract(urls_or_images, additional_options={})
      options = extract_options(urls_or_images, additional_options)
      result = JSON.parse(self.class.post(extract_service_path, body: options))
      raise_if_request_failed!(result)
      result
    end

    private

    def extract_options(urls_or_images, additional_options)
      ExtractOptions.new(base_options, @api_secret).options(urls_or_images, additional_options)
    end

    def base_options
      { v: @version, api_key: @api_key }
    end
  end
end
