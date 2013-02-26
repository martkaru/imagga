require "json"

module Imagga

  class CropResultBuilder
    def build_from(result)
      result['smart_croppings'].map { |crop_node| CropInfo.new(crop_node) }
    end
  end

end
