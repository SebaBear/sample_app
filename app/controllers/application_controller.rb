class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def home1
    render html:"Home sweet home!"
  end
end
