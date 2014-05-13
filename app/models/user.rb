class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook]

def self.find_for_facebook_oauth(auth, user)
  binding.pry
  if user
    user.uid = auth.uid
    user.fb_token = auth['credentials']['token']
    user.save
  end
  # uncomment for add facebook friends
  # add_fb_friends(user, auth);
  [user, auth]
end

end
