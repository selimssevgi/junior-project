Rails.application.routes.draw do

  get 'sessions/new'

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
  
  get    'signup'      => 'users#new'  
  resources :users 
  #resources :users, except: [:new]

  get    'login'       => 'sessions#new'
  post   'login'       => 'sessions#create'
  delete 'logout'      => 'sessions#destroy'

  resources :movies    # only: [:index, :show]
  resources :watchlists, only: [:create, :destroy]
  get    'watchlist'   => 'watchlists#index'
end
