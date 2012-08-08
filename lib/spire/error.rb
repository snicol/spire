module Spire
    class Error
        def initialize(opts={:status => 200, :message=> "Unknown Error"})
            case opts[:status]
            when 200
                self.return_error(opts[:message], opts[:status])
            when 404
              if opts[:message]
                self.return_error(opts[:message], opts[:status])
              else
                self.return_404
              end
            when 444
                self.return_444
            when 401
                self.return_401
            when 204
                self.return_204
            when 301
                self.return_301
            end
        end

        def return_204
            @return = Response.new(self.style_error("204 - No content"), 'text/html;', 204)
        end

        def return_301
            @return = Response.new(self.style_error("301 - Moved permanently"), 'text/html;', 301)
        end
        
        def return_401
            @return = Response.new(self.style_error("401 - Not authorized"), 'text/html;', 401)
        end
        
        def return_404
            @return = Response.new(self.style_error("404 - File not found"), 'text/html;', 404)
        end
        
        def return_444
            @return = Response.new(self.style_error("No response made by the server, check for a valid response"), 'text/html;', 404)
        end
        
        def style_error(message)
            return "<h2 style=\"font-family: 'Helvetica Neue', HelveticaNeue, Arial, Helvetica, sans-serif; \">
                      #{message}
                    </h2>"
        end
        
        def return_error(message, status)
            @return = Response.new(self.style_error(message), 'text/html;', status)
        end

        def to_rack
            @return.to_rack
        end
    end
end