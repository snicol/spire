module Spire
  class Router
    def initialize(map)
      @map = map
    end

    def route(env)
      request = Rack::Request.new(env)
      request_path = env["REQUEST_PATH"]

      if request_path == "/favicon.ico"
        return Public.return_file "favicon.ico"
      end

      if !@map.exists? request_path
        return Error.return_error :message => "No route was not found!", :status => 404
      end

      if @map.should_use_auto(request_path)
        params = @map.disect(request_path)
        return self.run({:controller => params[1], :action => params[2]})
      end

      return self.run(@map.get(request_path), request)
    end 
    
    def run(maps_to, request)
      path = File.expand_path(__FILE__)
      path["lib/spire/router.rb"] = "app/controllers"

      require "#{path}/#{maps_to[:controller].capitalize}Controller.rb"
      @class = Kernel.const_get(maps_to[:controller].capitalize).new(request)
    
      result = @class.method(maps_to[:action]).call
      buffer = @class.get_buffer
      
      if !buffer && !result
        return Error.return_error :message => "No method/Response from method. See #{@app["controller"]}##{@app["action"]} and check for a response", :status => 404
      end

      content_type = "text/html;"
      status = 200

      if @class.instance_variable_get(:@status)
        status = @class.instance_variable_get(:@status)
      end
      
      if @class.instance_variable_get(:@content_type) 
        content_type = @class.instance_variable_get(:@content_type) 
      end
      
      if result
        buffer = buffer + result
      end

      return Response.new(buffer, content_type, status)
    end

    def call(env)
      response = self.route(env)

      puts response
      if response
        response.to_rack
      else
        Error.return_error :status => 444
      end
    end
  end
end
