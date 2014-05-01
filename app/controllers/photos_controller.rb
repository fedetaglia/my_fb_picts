class PhotosController < ApplicationController
skip_before_filter :authenticate_user!, only: [:landing]

def index
end
  
end