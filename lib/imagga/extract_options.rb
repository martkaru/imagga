module Imagga
  class ExtractOptions
    attr_accessor :base_options

    def initialize(base_options, api_secret)
      @base_options = base_options
      @api_secret = api_secret
    end

    def options(urls_or_images, additional_options={})
      options = base_options.merge(
        method: 'imagga.colorseach.extract',
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
      [urls_or_images].flatten.map{|o| o.url rescue o}.join(',')
    end

    def build_ids(urls_or_images)
      ids = [urls_or_images].flatten.map{|o| o.id rescue 0}
      return if ids.uniq == [0]
      ids.join(',')
    end

    def sign(options)
      sorted_options_string = options.keys.sort.map do |key|
        "%s=%s" % [key.to_s, options[key]]
      end.join('') << @api_secret
      Digest::MD5.hexdigest(sorted_options_string)
    end

  end
end
