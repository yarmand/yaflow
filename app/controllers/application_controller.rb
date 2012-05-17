class ApplicationController < ActionController::Base
  protect_from_forgery

  def use_or_welcome
    redirect_to "/static/welcome.html" unless user_signed_in?
  end
end
