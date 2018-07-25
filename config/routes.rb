Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users, only: [:new, :create]
  resources :stations, only: [:show, :index, :destroy, :create, :update]
  get '/stations-dashboard', to: 'stations#dashboard'
  resources :conditions, only: [:index, :show]
  resources :trips, only: [:show]
  resources :dashboard, only: [:index]
  resources :accessories, only: [:show]
  resources :trips, only: [:index]
  get '/bike-shop', to: 'accessories#index'
  resources :carts, only: [:create]
  get '/trips-dashboard', to: 'trips#dashboard'
  namespace :admin do
    resources :stations, only: [:new, :edit]
  end
end
