require 'api_constraints'

CarPoolWeb::Application.routes.draw do
  resources :carpools do
    memeber

  devise_for :users
  
  #API Namespace ... Constraint to api.feiron
  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: :true) do
      devise_for :users
      match "base/test" => "base#test", via: :get
      
      #Pool methods
      match "pool/create" => "pool#create", via: :get
      match "pool/join" => "pool#join", via: :get
      match "pool/user/:id" => "pool#by_user", via: :get
      match "pool/:id" => "pool#get_pool", via: :get
      match "pools/location" => "pool#locate_pools", via: :get
      match "pools" => "pool#all_pools", via: :get
      
    end
  end
  
  resource :user
  root :to => "home#index"  
  match 'travelers' => 'home#travelers', :as => :travelers
end
