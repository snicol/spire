require 'spire/http'
 
module Spire
  class MainController
    
    def initialize(base_path)
      @base_path = base_path
    end
    
    def render(view)
      data = {}
      instance_variables.each do |var|
        data[var] = instance_variable_get(var)
      end
      
      type = view.split('.')[1]

      if type == "html"
        IO.read(@base_path+'/views/'+view)
      elsif type == "haml"
        require 'haml' 
        contents = IO.read(@base_path+'/views/'+view)
        Haml::Engine.new(contents).render(Object.new)
      elsif type == "rhtml"
        require 'erubis'
        contents = IO.read(@base_path+'/views/'+view)
        eruby = Erubis::Eruby.new(contents)
        return eruby.result(data)
      end
    end
    
  end
end
