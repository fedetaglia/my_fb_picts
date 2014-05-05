class PagesController < ApplicationController
skip_before_filter :authenticate_user!, only: [:landing, :index]

  def landing
    render layout: "landing"
  end

  def index
  end
  
end