module Spire
  class Router
    def initialize(base_path, routes)
      @base_path = base_path
      @routes = routes
    end

    def disect(env)
      req = env['REQUEST_PATH'].split("/")
      @request = {}
      @request[:controller] = req[1]
      @request[:action] = req[2]
    end

    def route
      @controller_value = nil
      @action_value = nil
      if @request[:controller] == nil
         route = @routes['default'].split("#")
         @controller_value = route[0].capitalize
         if @request[:action] == nil 
           @action_value = "index"
         else
           @action_value = route[1]
         end
      else
        @routes.each do |key, value|
          keys = key.split("/")
          values = value.split("#")
          if @request[:controller] == keys[1] && @request[:action] == keys[3]
            @controller_value = values[0].capitalize
            @action_value = values[1]
          elsif @request[:controller] == keys[1]
            @controller_value = values[0].capitalize
            @action_value = values[1]        
          end
        end
      end
        unless @controller_value
          return Response.new('404 - Page or route not found!')
        else
          return self.run
        end
    end 

    def run
      require "#{@base_path}/controllers/#{@controller_value}Controller"
      @app = Kernel.const_get(@controller_value).new(@base_path)
      return @app.method(@action_value).call
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