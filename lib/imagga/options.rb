module Imagga
  class BaseOptions
    include Parametizer
    attr_accessor :api_key, :api_secret, :version

    def initialize(api_key, api_secret)
      @version    = '1.0'
      @api_key    = api_key    || raise_missing(:api_key)
      @api_secret = api_secret || raise_missing(:api_secret)
    end

    def base_options
      { v: version, api_key: api_key }
    end

    def sign(options)
      sorted_options_string = options.keys.sort.map do |key|
        "%s=%s" % [key.to_s, options[key]]
      end.join('') << api_secret
      Digest::MD5.hexdigest(sorted_options_string)
    end
  end

  class ExtractOptions < BaseOptions
    def options(opts={})
      opts.merge!(base_options).merge!(method: method)
      opts.merge!(build_boolean_options(opts, boolean_fields))
      opts.merge!(sig: sign(opts))
    end

    def method
      'imagga.colorsearch.extract'
    end

    def boolean_fields
      [:extract_overall_colors, :extract_object_colors]
    end
  end

  class RankOptions < BaseOptions
    include Imagga::Exceptions

    def options(opts={})
      opts.merge!(base_options).merge!(
        method:       method,
        color_vector: opts.delete(:color_vector),
        type:         opts.delete(:type)  { raise_missing('type') },
        dist:         opts.delete(:dist)  { raise_missing('dist') },
        count:        opts.delete(:count) { raise_missing('count') }
      )
      opts.merge!(sig: sign(opts))
    end

    def method
      'imagga.colorsearch.rank'
    end
  end

  class CropOptions < BaseOptions
    def options(urls_or_images, additional_options={})
      options = base_options.merge(
        method: method,
        urls: build_urls(urls_or_images),
      )

      if resolutions = build_comma_separated_string(urls_or_images, :resolution, ',')
        options.merge!(resolutions: resolutions)
      end
      options.merge!(build_boolean_options(additional_options, :no_scaling))
      options.merge!(sig: sign(options))
    end

    def method
      'imagga.process.crop'
    end
  end
end
