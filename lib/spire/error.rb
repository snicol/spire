module Spire
    class Error
        def initialize(message, status='200')
            @return = Response.new(message, 'text/html; charset=uft8;', status)
        end

        def to_rack
            @return.to_rack
        end
    end
end
