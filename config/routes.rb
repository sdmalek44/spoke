Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"
  get '/login', to: 'sessions#new'
  resources :users, only: [:new, :create]
  resources :stations, only: [:show, :index]
  resources :conditions, only: [:index, :show]
  resources :trips, only: [:show]
<<<<<<< HEAD



||||||| merged common ancestors
=======
  resources :dashboard, only: [:index]
  resources :accessories, only: [:show]
>>>>>>> 84981c41cdaeb69320d4b30483ebc1dfe10a35c4
end
