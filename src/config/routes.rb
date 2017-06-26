Rails.application.routes.draw do
  root 'dashboard#main'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks' #TODO: a long-term approach to user sessions [prob dont need devise]
  }

  devise_scope :user do
    get 'logout', to: 'users/sessions#destroy'
  end

  namespace :api, defaults: { format: :json } do
    get '/', to: 'root#main', as: :root
    get '/me', to: 'root#me'
    get '/req', to: 'root#req'
    get '/my_top_artists', to: 'root#my_top_artists'
  end

  require 'sidekiq/web'
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    # Protect against timing attacks: (https://codahale.com/a-lesson-in-timing-attacks/)
    # - Use & (do not use &&) so that it doesn't short circuit.
    # - Use `secure_compare` to stop length information leaking
    ActiveSupport::SecurityUtils.secure_compare(username, ENV['SIDEKIQ_USERNAME']) &
      ActiveSupport::SecurityUtils.secure_compare(password, ENV['SIDEKIQ_PASSWORD'])
  end
  mount Sidekiq::Web => '/admin/sidekiq'

  get '*path', to: 'dashboard#main', as: :bootstrap # otherwise fall back to bootstrapping react app
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
