MyThreeBest::Application.routes.draw do

  # - Homepage
  root :to => "pages#index"

  # - Auth Routes
  devise_for :users do
    get "/login", :to => redirect("/auth/facebook"), :as => :new_user_session
    get "/logout", :to => "devise/sessions#destroy"
  end

  match "/auth/:provider/callback" => "sessions#create"

  # - Friends
  #resources :friends
  match "/friends" => "friends#index", :as => :friends_show

  # -  Invites routes
  match "/invite/all" => "invites#all", :as => :invite_all
  match "/invite/:user_id" => "invites#create", :as => :invite_friend
  resources :invites

  # - Vote Routes
  match "/vote/:user_id" => "votes#new", :as => :new_vote
  match "/vote/:user_id/:photo_id" => "votes#create", :as => :save_vote

end
