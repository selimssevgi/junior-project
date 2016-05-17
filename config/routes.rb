Rails.application.routes.draw do

  get 'comments/destroy'

  get 'recommendations/index'

  get 'watchedlists/index'

  # first form
  # root 'static_pages#home'
  # get 'static_pages/help'
  # get 'static_pages/about'
  # get 'static_pages/contact'

  # second form
  # now it can be used like:
  # help_path -> '/help'
  # help_url  -> 'http://www.example.com/help'
  # url part sometimes required for http redirects!
  
  root                    'static_pages#home'
  get    'help'        => 'static_pages#help'
  get    'about'       => 'static_pages#about'
  get    'contact'     => 'static_pages#contact'
  get    'stats'       => 'static_pages#stats'
  get    'engine_rate' => 'static_pages#engine_rate'
  
  get    'signup'      => 'users#new'  
  resources :users 
  #resources :users, except: [:new]

  get    'login'       => 'sessions#new'
  post   'login'       => 'sessions#create'
  delete 'logout'      => 'sessions#destroy'

  resources :searches
  resources :movies    # only: [:index, :show]
  resources :movies do 
    resources :comments
  end
  resources :comments
  resources :watchlists, only: [:create, :destroy]
  resources :recommendations, only: [:index, :destroy]
  resources :watchedlists, only: [:create, :destroy]
  resources :ratings, only: [:index, :create]
  get    'my_watchlist'   => 'watchlists#index'
  get    'watched_movies'   => 'watchedlists#index'
end
