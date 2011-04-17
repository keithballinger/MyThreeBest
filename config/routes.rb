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
  #match "/friends" => "friends#index", :as => :friends_show

  # -  Invites routes
  match "/invite/all" => "invites#all", :as => :invite_all
  match "/invite/:user_id" => "invites#create", :as => :invite_friend
  match "/invite/:user_id/new" => "invites#new", :as => :new_invite
  #resources :invites

  # - Vote Routes
  match "/votes" => "votes#index", :as => :votes
  match "/votes/:user_id" => "votes#show", :as => :friend_votes
  match "/vote/:user_id" => "votes#new", :as => :new_vote
  match "/vote/:user_id/save" => "votes#create", :as => :save_vote
  match "/unvote/:user_id/:photo_id" => "votes#destroy", :as => :delete_vote

  resources :users, :only => [:index, :update] do
    resources :photos, :only => [:index]
  end
  #match "/users/:id" => "users#update", :as => :user

  match "/:public_page_url" => "users#show", :as => :public_profile
end
