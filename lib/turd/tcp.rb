module Turd
  class Tcp

    def self.connect(request_definition)

      response = String.new

      before = Time.now.to_f

      timeout(10) {
        TCPSocket.open(request_definition[:options][:host], request_definition[:options][:port]) do |socket|
          response = socket.gets
        end
      }

      after = Time.now.to_f

      {
        :response => response,
        :total_time => after - before
      }
    end

  end
end