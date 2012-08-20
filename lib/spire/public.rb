require 'spire/resource/mime'

module Spire
  class Public
    def initialize(opts={:render=>true})
      @opts = opts
    end

    def self.return_file(file)
      file_object = Public.new :file => file, :render => true
      file = file_object.create_response

      if file == 404  
        return Error.return_error :status => 404
      else
        return Response.new(file[:file], file[:content_type], 200)
      end
    end
    
    def create_response
      file_extension = File.extname(@opts[:file])
      Mime.return_mimes ? @content_type = Mime.return_mimes[file_extension] : false
      
      if !@opts[:render]
        return [false, @content_type]
      end

      path = File.expand_path(__FILE__)
      path["lib/spire/public.rb"] = "public/#{@opts[:file]}"

      if File.exists?(path)
        file = IO.read(path)
        @return = {}
        @return[:file] = file
        @return[:content_type] = @content_type
        return @return
      else
        return 404
      end
    end
            
  end
end