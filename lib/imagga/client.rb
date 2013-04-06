module Imagga
  class Client < CoreClient
    def extract(urls_or_images, options={})
      options.merge!(ImageOrUrlParametizer.new.parametrize(urls_or_images))
      ExtractResultBuilder.new.build_from(super(options))
    end

    def rank(options={})
      colors = options.delete(:colors) { raise_missing('colors') }
      options.merge!(RankColorParametizer.new.parametrize(colors))
      RankResultBuilder.new.build_from(super(options))
    end

    def crop(urls_or_images, additional_options={})
      CropResultBuilder.new.build_from(super(options))
    end
  end
end
