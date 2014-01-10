module Turd
  class Http

    def self.request(request_definition)

      request = Typhoeus::Request.new(
        request_definition[:url],
        request_definition[:options]
      )

      request.run

    end

  end
end