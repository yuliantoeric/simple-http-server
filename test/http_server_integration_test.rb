require 'test_helper'
require 'socket'
require 'http_server'

class HttpServerIntegrationTest < Minitest::Test
  def test_server_echo_request_from_tcp_client
    request_message = "GET / HTTP/1.1\r\nHost: localhost:5000\r\n\r\n"
    response = ""

    Thread.new do
      server = HttpServer.new port: 5000
      server.start
    end

    server = TCPSocket.new 'localhost', 5000
    server.puts request_message
    response += server.gets
    content_length = 0
    while line = server.gets
      response += line
      key, value = line.split(':', 2)
      content_length = value.to_i if key.downcase == 'content-length'
      break if line =~ /^\s*$/
    end
    response += server.read(content_length) if content_length > 0
    server.close

    assert_equal "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\nContent-Length: #{request_message.bytesize}\r\nConnection: close\r\n\r\n#{request_message}", response
  end
end
