Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root 'static_pages#home'
  get 'sessions/new'
  get 'users/new'
  get 'pages/home', to: 'static_pages#home'
  get 'pages/help', to: 'static_pages#help'
  get 'pages/iems', to: 'static_pages#iems'
  get 'pages/how-to-order', to: 'static_pages#order'
  get 'pages/technology', to: 'static_pages#technology'
  get 'pages/review', to: 'static_pages#review'
  get 'pages/products', to: 'static_pages#products'
  get 'collections/stage', to: 'collections#stage'
  get 'collections/studio', to: 'collections#studio'
  get 'collections/audiophile', to: 'collections#audiophile'
  get '/login', to: 'sessions#new'
  get '/signup', to: 'users#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users	
  resources :hashtags
  resources :reviews, only: [:create, :destroy, :show, :new, :index] do
    collection { get :search, to: 'reviews#index' }
    resources :comments, only: [:index, :create]
    resources :likes
  end
  resources :products do
    resources :requests
  end
  resources :comments
  namespace :admin do
   resources :requests, only: [:index, :destroy]
  end
end
