require "json"

module Imagga

  class ExtractResultBuilder
    def build_from(result)
      result['colors'].map { |image_node| ImageInfo.new(image_node) }
    end
  end

end
