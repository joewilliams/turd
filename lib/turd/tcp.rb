module Turd
  class Tcp

    def self.connect(request_definition)

      response = String.new
      before = Time.now.to_f

      begin
        TCPSocket.open(request_definition[:options][:host], request_definition[:options][:port]) do |socket|
          response = socket.gets
        end
      rescue Errno::ETIMEDOUT
        # timeout
      end

      after = Time.now.to_f

      {:response => response, :total_time => after - before}

    end

  end
end