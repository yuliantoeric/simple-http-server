require 'socket'

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
        client.print "HTTP/1.1 200 OK\r\n" +
                     "Content-Type: text/plain\r\n" +
                     "Content-Length: #{request.bytesize}\r\n" +
                     "Connection: close\r\n" +
                     "\r\n" + request
        client.close
      end
    end
  end
end
