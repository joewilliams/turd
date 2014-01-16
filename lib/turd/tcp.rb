module Turd
  class Tcp

    def self.connect(request_definition)

      response = String.new
      read_after = nil
      read_before = nil

      begin
        total_before = Time.now.to_f

        TCPSocket.open(request_definition[:options][:host], request_definition[:options][:port]) do |socket|
          read_before = Time.now.to_f
          response = socket.gets
          read_after = Time.now.to_f
        end

        total_after = Time.now.to_f
      rescue Errno::ETIMEDOUT
        # timeout
      ensure
        total_after = Time.now.to_f
      end

      if read_after && read_before
        read_time = read_after - read_before
      else
        read_time = nil
      end

      {
        :response => response,
        :total_time => total_after - total_before,
        :read_time => read_time
      }

    end

  end
end