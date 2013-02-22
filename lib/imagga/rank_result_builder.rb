module Imagga

  class RankResultBuilder
    def build_from(result)
      result['rank_similarity'].map { |rank| RankSimilarity.new(rank) }
    end
  end

end
