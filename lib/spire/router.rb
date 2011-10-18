module Spire
  class Router
    def initialize(base_path, routes)
      @base_path = base_path
      @routes = routes
      @app = {}
    end

    def disect(env)
      req = env['REQUEST_PATH'].split("/")
      @request = {"controller" => req[1], "action" => req[2]}
    end

    def route
      if @request["controller"] == "public"
        self.return_file
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
        return Error.new :status => 404
      end
      
      return self.run
    end 
    
    def return_file
      # still need to add checks for mime types. this will be done in a seperate class once i get round to it
      return Response.new(File.open("/public/#{@request["action"]}", "r").read)
    end
    
    def run
      require "#{@base_path}/controllers/#{@app["controller"]}Controller"
      @class = Kernel.const_get(@app["controller"]).new(@base_path)
    
      result = @class.method(@app["action"]).call
      
      content_type = "text/html;"
      status = 200
      
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
