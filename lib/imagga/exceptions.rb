module Imagga
  module Exceptions
    def raise_missing(attribute)
      raise ArgumentError, "%s is missing" % attribute.to_s
    end

    def raise_if_request_failed!(result)
      if result.respond_to?(:keys) && result.keys.include?('error_code')
        raise Imagga::ClientException.new(result['error_code'].to_i), result['error_message'], caller[0..-1]
      end
    end
  end

  class ClientException < StandardError
    attr_accessor :error_code
    def initialize(error_code)
      @error_code = error_code
      super
    end
  end
end
