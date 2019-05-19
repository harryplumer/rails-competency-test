Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :articles
  resources :admin, only: [:index, :edit, :update, :new, :create]
  get "/change_role/:id", to: "home#change_role", as: "change_role"
  root "home#index"
end
