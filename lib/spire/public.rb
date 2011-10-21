require 'spire/resource/mime'

module Spire
  class Public
    def initialize(opts={:render=>true})
      @opts = opts
      mime = Mime.new
      @mime_types = mime.return_mimes
    end
    
    def extension_check
      file_extension = File.extname(@opts[:file])
      @mime_types.each do |ext, type|
        if file_extension == ext
          @content_type = type
        end
      end
      
      if @opts[:render]
        self.create_response
      else
        return [false, @content_type]
      end
    end
    
    def create_response
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