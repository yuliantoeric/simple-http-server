class Response
  def initialize(body:)
    @body = body
  end

  def to_s
    "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\nContent-Length: #{@body.bytesize}\r\nConnection: close\r\n\r\n#{@body}"
  end
end
