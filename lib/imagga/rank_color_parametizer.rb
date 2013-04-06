module Imagga
  class RankColorParametizer
    include Parametizer

    def parametrize(rank_color_or_colors)
      { color_vector: build_vector(rank_color_or_colors) }
    end

    def build_vector(rank_color_or_colors)
      [rank_color_or_colors].flatten.map{ |o| build_rank_color_string(o) rescue o }.join(',')
    end

    def build_rank_color_string(rank_color)
      "%i,%i,%i,%i" % [rank_color.percent, rank_color.r, rank_color.g, rank_color.b]
    end
  end
end
