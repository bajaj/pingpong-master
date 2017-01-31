Rails.application.routes.draw do
  devise_for :users
  
  root to: "home#index"
  
  #root to: 'leader_board#list'
  
  get '/history', to: 'home#history'
  get '/log',     to: 'games#new'

  resources :games, only: [:new, :create]
  
  resources :leader_board, only: [:list]
  
end
