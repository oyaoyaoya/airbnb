Rails.application.routes.draw do

  root 'pages#search'

  devise_for :users,
              path: '',
              path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile'},
              controllers: {omniauth_callbacks: 'omniauth_callbacks',
                registrations: 'registrations'
              }

  resources :users, only: [:show, :create, :update] do
    member do
      get 'image_upload'
      get 'reviews_about_you'
      get 'reviews_by_you'
      get 'dashboard'
    end
  end

  resources :rooms, except: [:edit] do
    member do
      get 'listing'
      get 'listing_details'
      get 'pricing'
      get 'description'
      get 'photo_upload'
      get 'amenities'
      get 'location'
      get 'preload'
      get 'preview'
      get 'co_hosts'
      get 'local_laws'
    end
    resources :photos, only: [:create, :destroy]
    resources :reservations, only: [:create]
    resources :calendars
  end

  resources :guest_reviews, only: [:create, :destroy]
  resources :host_reviews, only: [:create, :destroy]

  get '/your_trips' => 'reservations#your_trips'
  get '/your_reservations' => 'reservations#your_reservations'

  get 'search' => 'pages#search'
  get 'dashboard' => 'users#dashboard'

  resources :reservations, only: [:approve, :decline] do
    member do
      post '/approve' => "reservations#approve"
      post '/decline' => "reservations#decline"
    end
  end

  resources :conversations, only: [:index, :create]  do
    resources :messages, only: [:index, :create]
  end
  
  get '/host_calendar' => "calendars#host"
  mount ActionCable.server => '/cable'
end
