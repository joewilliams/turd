module Turd
  class Assert

    def self.assert(request_definition, response, response_definition)

      case request_definition[:type]

      when "tcp"
        response_definition.each do |option, value|
          if option == :response
            value.each do |v|
              if response[:response].include?(v)
                return response
              else
                response.store(:failed, option)
                raise AssertionFailure.new(response), "#{option} substring failure. expected #{v}, got #{response}"
              end
            end
          elsif option == :total_time
            if response[:total_time] > value
              response.store(:failed, option)
              raise AssertionFailure.new(response), "#{option} timing value was greater than allowed. expected #{value}, got #{response[:total_time]}"
            else
              return response
            end
          end
        end

      when "http"
        response_definition.each do |option, value|

          if option == :response_headers || option == :response_body
            value.each do |v|
              if !response.options[option].include?(v)
                response.options.store(:failed, option)
                raise AssertionFailure.new(return_http_response(response)), "#{option} substring failure. expected #{v}, got #{response.options[option]}"
              end
            end
          elsif option.to_s.include?("_time")
            if response.options[option] > value
              response.options.store(:failed, option)
              raise AssertionFailure.new(return_http_response(response)), "#{option} timing value was greater than allowed. expected #{value}, got #{response.options[option]}"
            end
          else
            if response.options[option] != value
              response.options.store(:failed, option)
              raise AssertionFailure.new(return_http_response(response)), "#{option} did not match response definition. expected #{value}, got #{response.options[option]}"
            end
          end
        end
      end

      return return_http_response(response)
    end

    def self.return_http_response(response)
      response.options.delete(:debug_info)
      response.options
    end
  end

  class AssertionFailure < RuntimeError
    attr :response

    def initialize(response)
      @response = response
    end
  end
end
