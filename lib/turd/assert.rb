module Turd
  class Assert

    def self.assert(request_definition, response, response_definition)

      case request_definition[:type]

      when "tcp"
        response_definition.each do |option, value|
          if option == :response
            value.each do |v|
              if response[:response].include?(v)
                # do nothing
              else
                raise "#{option} substring failure. expected #{v}, got #{response}"
              end
            end
          end
        end

      when "http"
        response_definition.each do |option, value|

          if option == :response_headers || option == :response_body
            value.each do |v|
              if response.options[option].include?(v)
                # do nothing
              else
                raise "#{option} substring failure. expected #{v}, got #{response.options[option]}"
              end
            end
          elsif option.to_s.include?("_time")
            if response.options[option] > value
              raise "#{option} timing value was greater than allowed. expected #{value}, got #{response.options[option]}"
            else
              # do nothing
            end
          else
            if response.options[option] == value
              # do nothing
            else
              raise "#{option} did not match response definition. expected #{value}, got #{response.options[option]}"
            end
          end
        end
      end

    end
  end
end