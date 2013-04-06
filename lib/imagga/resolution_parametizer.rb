module Imagga
  class ResolutionParametizer
    include Parametizer

    def parametrize(resolution_array_or_string)
      { resolutions: build_resolutions(resolution_array_or_string) }
    end

    def build_resolutions(resolution_array_or_string)
      [resolution_array_or_string].flatten.map{ |o| build_resolution_string(o) rescue o }.join(',')
    end

    def build_resolution_string(resolution)
      resolution.gsub('x', ',')
    end
  end
end
