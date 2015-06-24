Rails.application.routes.draw do
  devise_for :users, :match => '', :path => "",
  :controllers => {
    :sessions => "users/sessions",
    :registrations => "users/registrations",
    :confirmations => "users/confirmations",
    :unlocks => "users/unlocks",
    :passwords => "users/passwords",
    :omniauth_callbacks => "users/omniauth_callbacks"
  }, 
  :path_names => {
    :sign_up => 'sign_up',
    :sign_in => 'users',
    :sign_out => 'users/sign_out'
  }

  namespace :network do
    resources :users,           :only => [:index, :show]
    resources :posts,           :only => [:create, :destroy]
    resources :friendships,     :only => [:create, :destroy]
  end
  
  # root 'home#index'
  devise_scope :user do
    root to: "users/registrations#new"
  end
end
