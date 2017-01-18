Rails.application.routes.draw do

  resources :users
  resources :events
  resources :organizations
  devise_for :users
  root 'landing_page#index'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
