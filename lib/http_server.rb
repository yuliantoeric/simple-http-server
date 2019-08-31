require 'socket'

require_relative 'response'

class HttpServer
  def initialize(port:)
    @port = port
  end

  def start
    server = TCPServer.new @port
    loop do
      Thread.start(server.accept) do |client|
        request = client.gets
        content_length = 0
        while line = client.gets
          request += line
          key, value = line.split(':', 2)
          content_length = value.to_i if key.downcase == 'content-length'
          break if line =~ /^\s*$/
        end
        request += client.read(content_length) if content_length > 0
        response = Response.new body: request
        client.print response
        client.close
      end
    end
  end
end
