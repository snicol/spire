require 'spire/http'

module Spire
  class MainController
    def render(view)
      file = File.open('./app/views/'+view+'.html', 'r')
      Response.new(file.read)
    end
  end
end