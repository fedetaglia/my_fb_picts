MyFbPicts::Application.routes.draw do

  root to: "pages#landing"

  get '/auth/instagram/test', to: 'photos#auth_instagram'
  get '/auth/facebook/callback', to: 'users#set_facebook_token'
  get '/auth/instagram/callback', :to => 'users#set_instagram_token'

  devise_for :users, :controllers => { omniauth_callbacks: "omniauth_callbacks" }
  
  resources :users, :only => [:show, :index]
  
  resources :photos do
    collection do
      get 'down', as: :down
    end
  end
  
  resources :pages
  
end