require 'spire/resource/mime'

module Spire
  class Public
    def initialize(opts={:render=>true})
      @opts = opts
    end
    
    def extension_check
      file_extension = File.extname(@opts[:file])
      Mime.return_mimes.each do |ext, type|
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

    def self.return_file(file)
      result = Public.new :file => file, :render => true
      file = result.extension_check
      puts file
      if file == 404
        return Error.new :status => 404, :message => "404 // File not found"
      else
        return Response.new(file[:file], file[:content_type], 200)
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