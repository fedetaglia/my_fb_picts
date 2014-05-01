class PagesController < ApplicationController
skip_before_filter :authenticate_user!, only: [:landing]

  def landing
  end
  
end