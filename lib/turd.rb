require 'rubygems'

require 'typhoeus'
require 'socket'
require 'timeout'

__DIR__ = File.dirname(__FILE__)

$LOAD_PATH.unshift __DIR__ unless
  $LOAD_PATH.include?(__DIR__) ||
  $LOAD_PATH.include?(File.expand_path(__DIR__))

require 'turd/http'
require 'turd/tcp'
require 'turd/assert'
require 'turd/version'

module Turd
  class << self

    def run(request_definition, response_definition)

      case request_definition[:type]
      when "http"
        response = Turd::Http.request(request_definition)
      when "tcp"
        response = Turd::Tcp.connect(request_definition)
      end

      Turd::Assert.assert(request_definition, response, response_definition)
      response
    end

  end
end