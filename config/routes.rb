Rails.application.routes.draw do
  root 'welcome#index'
  # http://localhost:3000/users/auth/lastfm/callback
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new', as: :new_user_session
    get 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  resources :users

  namespace :api, defaults: { format: :json } do
    # namespace :v1 do
      resources :users
      get 'top-artists', to: 'users#top_artists', as: :top_artists
      get 'recent-tracks', to: 'users#recent_tracks', as: :recent_tracks
    # end
  end

end
