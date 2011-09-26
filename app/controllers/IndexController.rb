class Index < Spire::MainController
  def index
    content = "test1"
    render("index", content)    
  end
end
