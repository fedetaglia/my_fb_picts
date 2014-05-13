require "instagram"
IG_URI_CALLBACK = 'https://0.0.0.0:3000/auth/instagram/callback'

class UsersController < ApplicationController

  def set_facebook_token
    
  end

  def set_instagram_token
    response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)

    @user = current_user
    @user.ig_token = request.env['omniauth.auth']["credentials"]["token"]
    @user.save
    # raise auth_hash.inspect
    redirect_to photos_path
    # render :json => auth_hash
  end


  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def social_params
    params.require(:user).permit(:facebook, :instagram)
  end




end