module Imagga
  module Parametizer
    def build_comma_separated_string(urls_or_images, field, default_to=nil)
      field_values = [urls_or_images].flatten.map{ |o| o.send(field) rescue default_to }
      return if field_values.uniq == [default_to]
      field_values.join(',')
    end

    def build_boolean_options(options, keys)
      [keys].flatten.inject({}) do |result, key|
        if options.keys.include?(key) && (value = options[key] ? 1 : 0)
          result[key] = value
        end
        result
      end
    end

    def build_direct_options(options, keys)
      [keys].flatten.inject({}) do |result, key|
        if options.keys.include?(key) && (value = options[key])
          result[key] = value
        end
        result
      end
    end

    def build_comma_separated_string(urls_or_images, field, default_to=nil)
      field_values = [urls_or_images].flatten.map{ |o| o.send(field) rescue default_to }
      return if field_values.uniq == [default_to]
      field_values.join(',')
    end
  end
end
