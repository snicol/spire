require 'spire/http'
require 'haml' 

module Spire
  class MainController
    
    def initialize(base_path)
      @base_path = base_path
    end
    
    def render(view, type="haml", data="")
      if type == "html"
        File.open(@base_path+'/views/'+view+'.html', 'r').read
      elsif type == "haml"
        file = File.open(@base_path+'/views/'+view+'.haml', 'r').read
        Haml::Engine.new(file).render(Object.new, :data => data)
      end
    end
    
  end
end