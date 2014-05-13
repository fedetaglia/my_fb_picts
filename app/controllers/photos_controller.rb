require 'instagram'
require 'open-uri'
require 'fileutils'

IG_URI_CALLBACK = 'https://0.0.0.0:3000/auth/instagram/callback'

class PhotosController < ApplicationController


skip_before_filter :authenticate_user!, only: [:index, :landing]

def index
  if current_user && current_user.fb_token
    @user = current_user
    graph = Koala::Facebook::API.new(@user.fb_token,ENV['FB_APP_SECRET'])
    @fb_photos = graph.graph_call('/me/photos',options = {limit: 25})
    # photo['images'][0]['source']
    logger.debug "DEBUGGER **** I found #{ @fb_photos.length } photos on your facebook ******"
  end

  if current_user && current_user.ig_token

  end

end


def auth_instagram
  redirect_to Instagram.authorize_url(:redirect_uri => IG_URI_CALLBACK, client_id: ENV['IG_APP_ID'], response_type: 'token' )
  # redirect_to "https://api.instagram.com/oauth/authorize/?client_id=#{ENV['IG_APP_ID']}&redirect_uri=#{IG_URI_CALLBACK}&response_type=code"
end


def show
end

def down
  folder_path = "#{Rails.root}/tmp/my_photos_#{current_user.id}"
  downloads = get_photo_url(params)
  save_photos_on_server( downloads, folder_path )
  zip_file_path = create_a_zip_file( folder_path, downloads )
  send_zip_file( zip_file_path )
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


def save_photos_on_server(downloads, folder_path)
    Dir.mkdir(folder_path) unless File.exist?(folder_path)
    count = 0
    Dir.chdir(folder_path) do
      downloads.each do |photo_url|
        open("image_#{count}.jpg", 'wb') do |file|
          file << open(photo_url).read
        end
        count = count + 1
      end
    end
end

def create_a_zip_file(folder_path,downloads)
  zip_file_path = "#{Rails.root}/tmp/my_photos_#{current_user.id}.zip"
  Zip::File.open( zip_file_path, Zip::File::CREATE ) do |zipfile|
    count = 0
    downloads.each do |down|
      open(folder_path + "/image_#{count}.jpg", 'r') do |photo|
        zipfile.add("photo_#{count}.jpg",photo)
      end
      count = count + 1
    end
  end
  FileUtils.remove_dir folder_path, true
  zip_file_path
end

def send_zip_file(zip_path)
  File.open(zip_path, 'r') do |f|
    send_data f.read, type: "application/zip", filename: "my_photos.zip"
  end
  File.delete(zip_path)
end

end