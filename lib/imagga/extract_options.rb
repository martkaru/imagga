module Imagga
  class BaseOptions
    attr_accessor :api_key, :api_secret

    def initialize(api_key, api_secret)
      @version    = '1.0'
      @api_key    = api_key    || raise_missing(:api_key)
      @api_secret = api_secret || raise_missing(:api_secret)
    end

    def base_options
      { v: @version, api_key: @api_key }
    end

    def sign(options)
      sorted_options_string = options.keys.sort.map do |key|
        "%s=%s" % [key.to_s, options[key]]
      end.join('') << @api_secret
      Digest::MD5.hexdigest(sorted_options_string)
    end
  end

  class ExtractOptions < BaseOptions

    def options(urls_or_images, additional_options={})
      options = base_options.merge(
        method: 'imagga.colorsearch.extract',
        urls: build_urls(urls_or_images),
      )

      if ids = build_ids(urls_or_images)
        options.merge!(ids: ids)
      end

      [:extract_overall_colors, :extract_object_colors].each do |key|
        if additional_options.keys.include?(key) && (value = additional_options[key] ? 1 : 0)
          options.merge!(key => value)
        end
      end

      options.merge!(sig: sign(options))
    end

    def build_urls(urls_or_images)
      [urls_or_images].flatten.map{ |o| o.url rescue o }.join(',')
    end

    def build_ids(urls_or_images)
      ids = [urls_or_images].flatten.map{ |o| o.id rescue 0 }
      return if ids.uniq == [0]
      ids.join(',')
    end

  end

  class RankOptions < BaseOptions
    def options(opts)
      color_vector = opts.fetch(:color_vector)
      type         = opts.fetch(:type)
      dist         = opts.fetch(:dist)
      count        = opts.fetch(:count)

      options = base_options.merge(
        method:       'imagga.colorsearch.rank',
        color_vector: color_vector,
        type:         type,
        dist:         dist,
        count:        count
      )

      options.merge!(sig: sign(options))
    end
  end
end
