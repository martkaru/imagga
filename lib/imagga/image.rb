module Imagga
  class Image
    include Imagga::Exceptions
    attr_accessor :url, :id

    def initialize(opts)
      @url = opts[:url] || raise_missing(:url)
      @id  = opts[:id]  || 0
    end
  end
end
