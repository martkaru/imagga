require "json"

module Imagga

  class CropResultBuilder
    def build_from(result)
      result['smart_croppings'].map { |image_node| ImageInfo.new(image_node) }
    end
  end

end
