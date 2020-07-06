require 'resque/scheduler/server'

Rails.application.routes.draw do
  resource :users, only: [:show, :edit, :update, :destroy], path: 'profile', as: 'user'

  resources :twitter_threads do
    resources :tweets, except: [:index, :show]
  end
  root 'pages#home'

  get "/auth/:provider/callback" => "sessions#create"
  delete "/logout" => "sessions#destroy", as: :logout

  mount Resque::Server.new, :at => "/resque"
end
