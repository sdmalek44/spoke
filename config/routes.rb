Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"
  get '/login', to: 'sessions#new'
  resources :stations, only: [:show, :index]
  resources :conditions, only: [:index, :show]
  resources :trips, only: [:show]
end
