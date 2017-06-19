Rails.application.routes.draw do

  get 'guides/show'

  ActiveAdmin.routes(self)

  namespace :admin do
    resources :users do
      resources :products
      resources :videos
      resources :photos
      resources :ratings
      resources :companies
      resources :reviews
    end
    resources :father_categories do
      resources :categories
    end
    resources :categories do
      resources :sub_categories
      resources :photos
      resources :videos
      resources :users
    end
    resources :sub_categories do
      resources :products
    end
    resources :companies do
      resources :products
      resources :users
    end
    resources :products do
      resources :videos
      resources :photos
      resources :prices
      resources :ratings
      resources :reviews
      resources :users
    end
    resources :videos do
      resources :users
    end
    resources :photos do
      resources :users
    end
    resources :distributors do
      resources :companies
    end
  end

  root to: 'home#welcome_page'
  devise_for :users, controllers: {
    registrations: 'registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :users do
    collection do
      get :review
      get :photo
      get :video

      get :reviews
      get :social
      get :favourites
    end
  end
  get 'ajax_destroy_recent_search', to: 'users#ajax_destroy_recent_search', as: :ajax_destroy_recent_search
  get 'ajax_destroy_favourite', to: 'users#ajax_destroy_favourite', as: :ajax_destroy_favourite
  get 'ajax_destroy_all_favourites', to: 'users#ajax_destroy_all_favourites', as: :ajax_destroy_all_favourites
  get 'ajax_destroy_recent_searches', to: 'users#ajax_destroy_recent_searches', as: :ajax_destroy_recent_searches
  get 'ajax_get_filter_options/:id' => 'products#set_filter_options', as: :set_filter_options

  post 'ajax_set_product_rating', to: 'products#ajax_set_product_rating', as: :ajax_set_product_rating

  resources :home, only: [:index]

  resources :search, only: [:index] do
    get 'suggestions', on: :collection
    member do
      get 'remove'
    end
  end
  resources :sub_categories, only: [:show] do
    resources :guides, only: [:show]
  end
  resources :guides, only: [:index]
  resources :products, only: [:show] do
    resources :reviews, defaults: { formats: [:json, :html] }
    resource :user_favourite_products, only: [:create, :destroy]
  end

  resource :pictures, format: false, only: :create
  resources :photos, only: [:create, :show, :edit, :update, :destroy]
  resources :videos, format: false, only: [:create, :show, :edit, :update, :destroy]

  namespace :info do
    resources :terms, only: :show
    resources :privacies, only: :show
    resources :questions, only: :show
    resources :abouts, only: :show
  end

  patch :select_locale, to: 'visitors#select_locale'

  post '/modals/:action', controller: :modals, format: false, as: :modals
  get '/modals/fetch' => 'modals#fetch', format: :json
end
