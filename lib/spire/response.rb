module Spire
  class Response
    attr_accessor :status_code, :headers, :content

    def initialize(content='', content_type='text/html; charset=utf8', status=200, manual_headers=nil)
      @content = content
      @headers = {'Content-Type' => content_type}
      @status_code = status
    end

    def to_rack
      [status_code, headers, [content]]
    end
  end
end