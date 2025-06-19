Rails.application.routes.draw do
  devise_for :users
resources :users, only: [:show] 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
get 'foods/new' => 'foods#new'
get 'recipes/index' => 'recipes#index'
get 'recipes/show' => 'recipes#show'
get 'recipes/new' => 'recipes#new'
get 'users/new' => 'users#new'
get 'recipes/:id' => 'recipes#show',as: 'recipe'
  patch 'recipes/:id' => 'recipes#update'
  delete 'recipes/:id' => 'recipes#destroy'
  get 'recipes/:id/edit' => 'recipes#edit', as:'edit_recipe'
  resources :foods
  resources :recipes do
  resources :likes, only: [:create, :destroy]
  resources :comments, only: [:create]
  end
  resources :users
  root 'recipes#new'

end

