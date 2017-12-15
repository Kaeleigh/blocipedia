Rails.application.routes.draw do
  devise_for :users
  resources :wikis
  resources :charges, only: [:new, :create, :destroy]
<<<<<<< HEAD
  
  get 'about' => 'welcome#about'

  root 'welcome#index'
=======
>>>>>>> 2dfe239862bd98d1f336e209ee8b249d11db33db

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
