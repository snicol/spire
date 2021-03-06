require 'spire/response'
require 'spire/resource/buffer'
 
module Spire
  
  class MainController
    attr_accessor :buffer
    attr_reader :request

    def initialize(request, app_root)
      @buffer = Buffer.new
      @request = request
      @app_root = app_root
    end

    def get_buffer
      @buffer.data
    end
    
    def render(opts={})
      instance_vars = {}
      instance_variables.each do |var|
        instance_vars[var] = instance_variable_get(var)
      end
      
      if opts[:text]
        @buffer.append(opts[:text])
      end

      if opts[:view]
        file_path = @app_root + "/views/#{opts[:view]}"
        return 404 unless File.exists?(file_path)
        contents = IO.read(file_path)
        extension = File.extname(file_path)

        case extension
        when '.haml'
          require 'haml' 
          insert = Haml::Engine.new(contents).render(Object.new, instance_vars)
        when '.rhtml'
          require 'erubis'
          eruby = Erubis::Eruby.new(contents)
          insert = eruby.result(instance_vars)
        else
         return false
        end
        @buffer.append(insert)
      end

      return nil
    end
    
  end
end
