module Imagga
  class Image
    include Imagga::Exceptions
    attr_accessor :url, :id, :resolution

    def initialize(opts)
      @url             = opts[:url] || raise_missing(:url)
      @id              = opts[:id]  || 0
      self.resolution  = opts[:resolution] # 123x23 or 123,23
    end

    def resolution=(res)
      @resolution = res.gsub('x', ',') rescue nil
    end

  end

  class ImageInfoBase
    def initialize(opts={})
      self.class.fields.each { |field| send("#{field}=", opts[field]) }
    end
  end

  class ImageInfo < ImageInfoBase

    def self.fields
      %w(url object_percentage color_variance image_packed foreground_packed background_packed)
    end

    def self.color_fields
      %w(image_colors foreground_colors background_colors)
    end

    def initialize(opts={})
      super(opts['info'].merge('url' => opts['url']))
      self.class.color_fields.each do |field|
        send("#{field}=", build_image_colors(opts['info'][field]))
      end
    end

    def build_image_colors(image_color_nodes)
      image_color_nodes && image_color_nodes.map { |color_node| ImageColor.new(color_node) }
    end

    attr_accessor *(fields + color_fields)

    def color_variance=(value)
      @color_variance = value.to_i
    end

  end

  class ImageColor < ImageInfoBase

    def self.fields
      %w(percent r g b html_code closest_palette_color closest_palette_color_parent closest_palette_distance)
    end

    attr_accessor *fields

    %w(r g b).each do |field|
      define_method("#{field}=") do |value|
        instance_variable_set("@#{field}", value.to_i)
      end
    end

    def percent=(value)
      @percent = value.to_f
    end

    def info
      "%.2f\%%, rgb: (%i,%i,%i), hex: %s" % [percent, r, g, b, html_code]
    end

  end

  class RankSimilarity < ImageInfoBase
    def self.fields
      %w(id dist)
    end

    attr_accessor *fields
  end

  class CropInfo < ImageInfoBase
    def self.fields
      %w(url)
    end

    def self.crop_fields
      %w(croppings)
    end

    def initialize(opts={})
      super({'url' => opts['url']})
      self.class.crop_fields.each do |field|
        send("#{field}=", build_image_crops(opts[field]))
      end
    end

    def build_image_crops(image_crop_nodes)
      image_crop_nodes && image_crop_nodes.map { |crop_node| ImageCrop.new(crop_node) }
    end

    attr_accessor *(fields + crop_fields)
  end

  class ImageCrop < ImageInfoBase
    def self.fields
      %w(target_width target_height x1 y1 x2 y2)
    end

    attr_accessor *fields

    %w(target_width target_height x1 y1 x2 y2).each do |field|
      define_method("#{field}=") do |value|
        instance_variable_set("@#{field}", value.to_i)
      end
    end

    def info
      "target: (%i,%i), crop: (%i, %i) to (%i, %i)" % [target_width, target_height, x1, y1, x2, y2]
    end

  end

end
