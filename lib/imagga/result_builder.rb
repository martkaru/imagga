module Imagga

  class BaseBuilder
    def build_from(result)
      result[key].map { |o| result_class.new(o) }
    end

    def key; self.class::KEY; end
    def result_class; self.class::CLASS; end
  end

  class RankResultBuilder < BaseBuilder
    KEY   = 'rank_similarity'
    CLASS = RankSimilarity
  end

  class ExtractResultBuilder < BaseBuilder
    KEY   = 'colors'
    CLASS = ImageInfo
  end

  class CropResultBuilder < BaseBuilder
    KEY   = 'smart_croppings'
    CLASS = CropInfo
  end

end
