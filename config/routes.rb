Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :stations, only: [:show, :index]
  resources :trips, only: [:show]
  resources :conditions, only: [:index]
end
