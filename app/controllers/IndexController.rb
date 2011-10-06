class Index < Spire::MainController
  def index
    Spire::Response.new(render("index", "haml", ["Welcome to Spire!", 
      "This is a base app to extend your own on. Have fun!"]))
  end
end
