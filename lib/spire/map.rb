module Spire
	class Map
		attr_accessor :auto

		def initialize
			@maps = Hash.new({})
			@auto = false
		end

		def route(opts={})
			@maps[opts[:url]] = opts[:to]
		end

		def get(url)
			return @maps[url]
		end

		def should_use_auto(url)
			if @maps[url] == {} && @auto
				return true
			end
		end

		def exists?(url)
			unless @maps[url] == {}
				return true
			end
		end

		def disect(request)
			return request.split("/")
    end

	end
end