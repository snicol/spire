require 'spire/http'
require 'haml' 

module Spire
  class MainController
    def render(view, type="haml", data="")
      if type == "html"
        File.open('./app/views/'+view+'.html', 'r').read
      elsif type == "haml"
        file = File.open('./app/views/'+view+'.haml', 'r').read
        Haml::Engine.new(file).render(Object.new, :data => data)
      end
    end
  end
end