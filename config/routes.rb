Rails.application.routes.draw do

  get 'relationships/create'
  get 'relationships/destroy'
  devise_for :users
  root to:'homes#top'
  get "home/top" => "homes#top"
  get "home/about" => "homes#about"
  resources :users, only: [:show, :edit, :update, :index]
  resources :books, only: [:index, :show, :edit, :create, :destroy, :update]do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
    resources :users do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member 
    get :followers, on: :member 
  end
end