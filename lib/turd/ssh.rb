require 'net/ssh'

module Turd
  class SSH
    def self.connect(request_definition)
      options = request_definition.fetch(:options)
      host = options.fetch(:server)
      username = options.fetch(:username)
      command = options.fetch(:command)
      stdin = options.fetch(:stdin, nil)
      key = options.fetch(:key, nil)

      response = {:stdout => "", :stderr => ""}
      ssh_options = key ? {:keys_only => true, :key_data => [key], :keys => [], :use_agent => false} : {}
      ssh_options[:non_interactive] = true

      started = Time.now.to_f
      connected = exited = stdout_started = nil
      Net::SSH.start(host, username, ssh_options) do |ssh|
        connected = Time.now.to_f
        ssh.open_channel do |channel|
          channel.exec(command) do |ch, success|
            if success
              channel.send_data(stdin) if stdin
              channel.eof!
              channel.on_request("exit-status") do |_, data|
                exited = Time.now.to_f
                response[:exit_status] = data.read_long
              end
              channel.on_data do |_, data|
                stdout_started = Time.now.to_f
                response[:stdout] << data
              end
            end
          end
        end
        ssh.loop
      end
      finished = Time.now.to_f
      response[:total_time] = finished - started
      response[:read_time] = exited - connected if exited and connected
      response[:sshauth_time] = connected - started if connected
      response
    end
  end
end
