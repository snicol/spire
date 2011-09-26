class Index < Spire::MainController
  def index
    Spire::Response.new(render("index", "haml", ["Index Page", "This is the index page!"])) 
  end
end
