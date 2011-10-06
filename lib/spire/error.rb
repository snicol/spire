require 'spire/http'

module Spire
  class Error
    def initialize(error_message, status=200)
      @error_message = error_message
      @status = status
    end
    
    def return_error
      if @status == 200
        return Response.new(@error_message, 'text/html; charset=utf8', 200)
      elsif @status == 404
        return Response.new(@error_message, 'text/html; charset=utf8', 404)
      end
    end
  end
end