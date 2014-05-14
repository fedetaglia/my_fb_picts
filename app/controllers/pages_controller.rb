class PagesController < ApplicationController
skip_before_filter :authenticate_user!, only: [:landing, :index, :privacy]
respond_to :html, :json

  def landing
    render layout: "landing"
  end

  def index
  end
  
  def privacy
  end 

end