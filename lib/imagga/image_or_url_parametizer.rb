module Imagga
  class ImageOrUrlParametizer
    include Parametizer

    def parametrize(urls_or_images)
      options = build_urls(urls_or_images)
      if (ids = build_ids(urls_or_images))[:ids]
        options.merge!(ids)
      end
      options
    end

    def build_urls(urls_or_images)
      { urls: [urls_or_images].flatten.map{ |o| o.url rescue o }.join(',') }
    end

    def build_ids(urls_or_images)
      { ids: build_comma_separated_string(urls_or_images, :id, 0) }
    end
  end
end
