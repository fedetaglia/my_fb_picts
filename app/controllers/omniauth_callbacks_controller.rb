class OmniauthCallbacksController < Devise::OmniauthCallbacksController  

  def facebook
    @user,auth = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
     if @user.persisted?       
      #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      redirect_to photos_url
    end
  end

end