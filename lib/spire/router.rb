module Spire
  class Router
    def initialize(base_path, routes)
      @base_path = base_path
      @routes = routes
    end

    def disect(env)
      req = env['REQUEST_PATH'].split("/")
      @request = {"controller" => req[1], "action" => req[2]}    
    end

    def route
      @controller_value = nil
      @action_value = nil
      if @request["controller"] == "favicon.ico"
        return Response.new(File.open("public/favicon.ico", 'r').read, "image/ico;")
      end
      if @request["controller"] == nil
         route = @routes['default'].split("#")
         @controller_value = route[0].capitalize
         @action_value = route[1]
      else
        @routes.each do |key, value|
          keys = key.split("/")
          values = value.split("#")
          if @request["controller"] == keys[1] && @request["action"] == keys[3]
            puts values[0]
            @controller_value = values[0].capitalize
            puts @controller_value
            @action_value = values[1]
          elsif @request["controller"] == keys[1]
            puts values[0]
            @controller_value = values[0].capitalize
            puts @controller_value
            @action_value = values[1]            
          end
        end
      end
      unless @controller_value
        return Error.new("<title>404</title><body><h2>404 // Page not found</h2></body>")
      end
      return self.run
    end 
    
    def run
      require "#{@base_path}/controllers/#{@controller_value}Controller"
      @app = Kernel.const_get(@controller_value).new(@base_path)
    
      result = @app.method(@action_value).call
      content_type = "text/html;"
      status = 200
      
      if @app.instance_variable_get(:@status)
        status = @app.instance_variable_get(:@status)
      end
      if @app.instance_variable_get(:@content_type) 
        content_type = @app.instance_variable_get(:content_type) 
      end
      
      return Response.new(result, content_type, status)
    end

    def call(env)
      self.disect(env)
      response = self.route

      puts response
      if response
        response.to_rack
      end
    end
  end
end
