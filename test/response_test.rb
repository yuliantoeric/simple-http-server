require 'test_helper'
require 'response'

class ResponseTest < Minitest::Test
  def test_to_s_returns_valid_http_response
    response = Response.new body: "Hello World!"
    assert_equal "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\nContent-Length: 12\r\nConnection: close\r\n\r\nHello World!", response.to_s
  end
end
