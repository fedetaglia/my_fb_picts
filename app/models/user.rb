class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable

def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
  user = User.where( provider: auth.provider, uid: auth.uid).first
  if !user
    registered_user = User.where( email: auth.info.email).first
    if registered_user
      user = registered_user
    else
      user = User.create(username:auth.extra.raw_info.name,
                          provider:auth.provider,
                          uid:auth.uid,
                          email:auth.info.email,
                          password:Devise.friendly_token[0,20],
                        )
    end    
  end
  # uncomment for add facebook friends
  # add_fb_friends(user, auth);
  user
end

end
