Rails.application.routes.draw do
  resources :expense_cards, :except => [:show] 
  resources :cards, :except => [:show]
  resources :transfers, :except => [:show]
  resources :kinds, :except => [:show]
  resources :sources, :except => [:show]
  resources :incomes, :except => [:show]
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
