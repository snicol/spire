require 'spire/http'
 
module Spire
  class MainController
    
    def render(opts={})
      data = {}
      instance_variables.each do |var|
        data[var] = instance_variable_get(var)
      end
      
      if opts[:text]
        return opts[:text]
      end
      
      if opts[:file]
        contents = Public.new :file => "test.html", :render => true
        file = contents.extension_check
        return file
      end
      if opts[:view].is_a? Array
        @storage = ""
        opts[:view].each do |file|          
          file_path = File.join($base_path, 'views', file)      
          return 404 unless File.exists?(file_path)
          contents = IO.read(file_path)
          extension = File.extname(file_path)

          case extension
            when '.haml'
              require 'haml' 
              @storage = @storage + Haml::Engine.new(contents).render(Object.new)
            when '.rhtml'
              require 'erubis'
              eruby = Erubis::Eruby.new(contents)
              @storage = @storage + eruby.result(data)
            else
              @storage = @storage + contents
          end
        end
       return @storage
      end
      
      file_path = File.join($base_path, 'views', opts[:view])
      return 404 unless File.exists?(file_path)
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
