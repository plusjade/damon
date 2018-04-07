class HomeController < ActionController::Base
  def index
    render plain: "🐶 Hello! I am an API server"
  end
end
