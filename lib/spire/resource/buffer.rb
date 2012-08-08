module Spire
	class Buffer
	  attr_accessor :data

	  def initialize
	    @data = String.new
	  end

	  def append(insert)
	    @data = @data + insert
	   end
	end
end