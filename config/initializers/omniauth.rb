Rails.application.config.middleware.use OmniAuth::Builder do

  provider :facebook, ENV["FB_APP_ID"], ENV["FB_APP_SECRET"]
  
  provider :instagram, ENV['IG_APP_ID'], ENV['IG_APP_SECRET']

end