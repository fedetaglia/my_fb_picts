require "instagram"
require 'open-uri'

IG_URI_CALLBACK = 'https://0.0.0.0:3000/auth/instagram/callback'

class PhotosController < ApplicationController
skip_before_filter :authenticate_user!, only: [:index, :landing]

def index
  if current_user.fb_token
    @user = current_user
    graph = Koala::Facebook::API.new(@user.fb_token,ENV['FB_APP_SECRET'])
    @fb_photos = graph.graph_call('/me/photos',options = {limit: 25})
    # photo['images'][0]['source']
  end

  if current_user.ig_token

  end

end


def auth_instagram
  redirect_to Instagram.authorize_url(:redirect_uri => IG_URI_CALLBACK, client_id: ENV['IG_APP_ID'], response_type: 'token' )
  # redirect_to "https://api.instagram.com/oauth/authorize/?client_id=#{ENV['IG_APP_ID']}&redirect_uri=#{IG_URI_CALLBACK}&response_type=code"
end


def show
end

def down
  downloads = get_photo_url(params)
  down_photos(downloads)

end



private

def get_photo_url(params)
  downloads = []
  params.keys.each do |param|
    if param.match(/https/)
      downloads << param
    end
  end
  downloads
end

def down_photos(downloads)
  count = 0
    downloads.each do |down|
      open(down, 'r') do |file|
         send_data file.read, type: file.content_type , disposition: 'attachment'
         # file << open(down).read
      end
      count = count + 1
    end
end


end