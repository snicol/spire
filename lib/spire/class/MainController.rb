require 'spire/http'

module Spire
  class MainController
    def render(view, content="", type="haml")
      if type == "html"
        return File.open('./app/views/'+view+'.html', 'r').read
      elsif type == "haml"
        file = File.open('./app/views/'+view+'.haml', 'r').read
        return Haml::Engine.new(file).render(s)
      end
    end
  end
end