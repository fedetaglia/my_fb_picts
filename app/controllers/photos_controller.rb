class PhotosController < ApplicationController
skip_before_filter :authenticate_user!, only: [:landing]

def index
  @user = current_user
  @graph = Koala::Facebook::API.new(session[:fb_access_token],ENV['FB_APP_SECRET'])
  @photos = @graph.graph_call('/me/photos',options = {limit: 1000})
end
  
end