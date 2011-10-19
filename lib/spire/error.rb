module Spire
    class Error
        def initialize(opts={})
            status = opts[:status] or 200
            message = opts[:message] or "Unknown Error"
            
            case status
            when 200
                self.return_error(message, status)
            when 404
                self.return_404
            when 401
                self.return_401
            when 204
                self.return_204
            when 301
                self.return_301
            when 444
                self.return_444
            end
        end

        def return_404
            @return = Response.new("404 // Page not found", 'text/html;', 404)
        end

        def return_401
            @return = Response.new("401 // Not authorized", 'text/html;', 401)
        end

        def return_204
            @return = Response.new("204 // No content", 'text/html;', 204)
        end

        def return_301
            @return = Response.new("301 // Moved permanently", 'text/html;', 301)
        end

        def return_error(message, status)
            @return = Response.new(message, 'text/html;', status)
        end
          
        def return_444
            @return = Response.new("No response made by the server, check for a valid response", 'text/html;', 404)
        end
        
        def to_rack
            @return.to_rack
        end
    end
end