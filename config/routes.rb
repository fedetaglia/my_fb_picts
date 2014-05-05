MyFbPicts::Application.routes.draw do

  root to: "pages#landing"

  get '/auth/:provider/callback', to: 'authentications#create'

  devise_for :users, :controllers => { omniauth_callbacks: "omniauth_callbacks" }
  resources :users, :only => [:show, :index]
  resources :photos
  resources :pages
  
end