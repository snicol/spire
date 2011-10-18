require 'spire/http'
 
module Spire
  class MainController
    
    def initialize(base_path)
      @base_path = base_path
    end
    
    def render(opts={})
      data = {}
      instance_variables.each do |var|
        data[var] = instance_variable_get(var)
      end
      
      if opts[:text]
        return opts[:text]
      end
            
      file_path = File.join(@base_path, 'views', opts[:view])
      return Error.new(:status => 404) unless File.exists?(file_path)
      contents = IO.read(file_path)
      extension = File.extname(file_path)

      case extension
      when '.haml'
        require 'haml' 
        Haml::Engine.new(contents).render(Object.new)
      when '.rhtml'
        require 'erubis'
        eruby = Erubis::Eruby.new(contents)
        eruby.result(data)
      else
        contents
      end
    end
    
  end
end
