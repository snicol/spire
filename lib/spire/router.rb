module Spire
  class Router
    def initialize(base_path, routes)
      $base_path = base_path
      @routes = routes
      @app = {}
    end

    def disect(env)
      req = env['REQUEST_PATH'].split("/")
      @request = {"controller" => req[1], "action" => req[2]}
    end

    def route
      @app["controller"] = nil
      
      if @request["controller"] == "favicon.ico"
        favicon = Public.new
        response = favicon.return_file!("favicon.ico")
        return Response.new(response, "image/x-icon", 200)
      end
      
      if @request["controller"] == nil
         route = @routes['default'].split("#")
         @app["controller"] = route[0].capitalize
         @app["action"] = route[1]
      else
        @routes.each do |key, value|
          keys = key.split("/")
          values = value.split("#")
          if @request["controller"] == keys[1] && @request["action"] == keys[3]
            @app["controller"] = values[0].capitalize
            @app["action"] = values[1]
          elsif @request["controller"] == keys[1]
            @app["controller"] = values[0].capitalize
            @app["action"] = values[1]            
          end
        end
      end
      
      unless @app["controller"]     
        return Error.new :message => "404 // Route not found in system/routes.rb", :status => 404
      end
      
      return self.run
    end 
    
    def return_file(file)
      result = Public.new :file => file, :render => true
      file = result.extension_check
      
      if file == 404
        return Error.new :status => 404, :message => "404 // File not found"
      else
        return Response.new(file[:file], file[:content_type], 200)
      end
    end
    
    def run
      require "#{$base_path}/controllers/#{@app["controller"]}Controller"
      @class = Kernel.const_get(@app["controller"]).new()
    
      result = @class.method(@app["action"]).call
      
      if result.is_a? Hash
        if result[:file]
          return Response.new(result[:file], result[:content_type], 200)
        end
      end
      
      content_type = "text/html;"
      status = 200
            
      if result == 404 or result == nil
        return Error.new :message => "404 // No method/Response from method. See #{@app["controller"]}##{@app["action"]} and check for a response", :status => 404
      end
      
      if @class.instance_variable_get(:@status)
        status = @class.instance_variable_get(:@status)
      end
      
      if @class.instance_variable_get(:@content_type) 
        content_type = @class.instance_variable_get(:content_type) 
      end
            
      return Response.new(result, content_type, status)
    end

    def call(env)
      self.disect(env)
      response = self.route

      puts response
      if response
        response.to_rack
      else
        Error.new :status => 444
      end
    end
  end
end
