class StaticController < ApplicationController
  def get
    render file: "static/#{params[:page]}"
  end
end
