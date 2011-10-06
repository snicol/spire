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
        File.open(@base_path+'/views/'+view, 'r').read
      elsif type == "haml"
        require 'haml' 
        file = File.open(@base_path+'/views/'+view, 'r').read
        Haml::Engine.new(file).render(Object.new, data)
      elsif type == "rhtml"
        require 'erubis'
        file = File.open(@base_path+'/views/'+view, 'r').read
        eruby = Erubis::Eruby.new(file)
        return eruby.result(data)
      end
    end
    
  end
end