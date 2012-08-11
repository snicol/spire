module Spire
    class Error
        def self.return_error(opts={:status => 200, :message => "An unknown error occured", :extended_message => ""})
            spec = Gem::Specification.find_by_name("spire")
            gem_root = spec.gem_dir

            contents = IO.read("#{gem_root}/lib/spire/templates/error/error.haml")
            require 'haml'
            
            error_template = Haml::Engine.new(contents).render(Object.new, {:@error_code => opts[:status], :@error_message => opts[:message], :@extended_message => opts[:extended_message]})
            return Response.new(error_template, 'text/html;', opts[:status])
        end

        def self.manual_error(opts={:status => 200, :message => "An unknown error occured"})
            return Response.new(opts[:message], 'text/html;', opts[:status])
        end

        def to_rack
            @return.to_rack
        end
    end
end