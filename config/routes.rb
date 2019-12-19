Rails.application.routes.draw do
  resources :kinds
  resources :sources
  resources :incomes
  resources :accounts, :except => [:show]
  resources :expenses, :except => [:show]
  resources :categories, :except => [:show]
  resources :suppliers, :except => [:show]
  devise_for :users
  resources :users, :except => [:show]
  get 'home/index'
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
