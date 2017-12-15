Rails.application.routes.draw do
  devise_for :users
  resources :wikis
  resources :charges, only: [:new, :create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
