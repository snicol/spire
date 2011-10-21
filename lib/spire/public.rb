require 'spire/resource/mime'

module Spire
  class Public
    def initialize(opts={:render=>true})
      @file = opts[:file]
      @render = opts[:render]
      mime = Mime.new
      @mime_types = mime.return_mimes
    end
    
    def extension_check
      file_extension = File.extname(@file)
      @mime_types.each do |ext, type|
        if file_extension == ext
          @content_type = type
        end
      end
      
      if @render
        self.create_response
      else
        return [false, @content_type]
      end
    end
    
    def create_response
      path = File.expand_path(__FILE__)
      path["lib/spire/public.rb"] = "public/#{@file}"
      return Error.new(:status => 404, :message => "404 // File not found") unless File.exists?(path)
      file = IO.read(path)
      @return = {}
      @return[:file] = file
      @return[:content_type] = @content_type
      return @return
    end
        
  end
end