Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/bike-shop', to: 'accessories#index'
  get '/trips-dashboard', to: 'trips#dashboard'
  get '/stations-dashboard', to: 'stations#dashboard'
  get '/dashboard', to: 'users#dashboard'
  resources :users, only: [:new, :create]
  resources :stations, only: [:show, :index]
  resources :trips, only: [:show, :index]
  resources :conditions, only: [:index, :show]
  get '/conditions-dashboard', to: 'conditions#dashboard'
  resources :accessories, only: [:show]
  resources :carts, only: [:create]
  namespace :admin do
    resources :stations, only: [:new, :edit, :create, :update, :destroy]
    resources :trips, only: [:new, :edit, :create, :update, :destroy]
    resources :conditions, only: [:new, :edit, :create, :update, :destroy]
    resources :accessories, only: [:create, :edit, :update]
    get '/bike-shop/new', to: 'accessories#new'
    post '/bike-shop', to: 'accessories#create'
    get '/bike-shop', to: 'accessories#index'
  end
  get '/admin/dashboard', to: 'admin/users#dashboard'
  get '/cart', to: 'carts#show'
  delete '/cart', to: 'carts#destroy'
  resources :orders, only: [:create, :show]
end
