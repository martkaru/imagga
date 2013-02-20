require "httparty"
require "json"

module Imagga
  class Client
    include HTTParty
    include Imagga::Exceptions
    attr_reader :api_key, :api_secret, :base_uri, :service_path

    def initialize(opts={})
      @api_key     = opts[:api_key]    || raise_missing(:api_key)
      @api_secret  = opts[:api_secret] || raise_missing(:api_secret)
      @base_uri    = opts[:base_uri]   || raise_missing(:base_uri)
      @service_path = '/colorsearchserver.php'

      Imagga::Client.base_uri @base_uri
    end

    def extract(urls_or_images, additional_options={})
      options = extract_options(urls_or_images, additional_options)
      puts options
      result = JSON.parse(self.class.post(service_path, body: options))
      raise_if_request_failed!(result)
      result
    end

    def rank(opts)
      result = JSON.parse(self.class.post(service_path, body: rank_options(opts)))
      raise_if_request_failed!(result)
      result
    end

    private

    def extract_options(urls_or_images, additional_options)
      ExtractOptions.new(api_key, api_secret).options(urls_or_images, additional_options)
    end

    def rank_options(opts)
      RankOptions.new(api_key, api_secret).options(opts)
    end
  end
end
