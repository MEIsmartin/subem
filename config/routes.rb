Subscribem::Engine.routes.draw do
  require 'subscribem/constraints/subdomain_required'

  constraints(Subscribem::Constraints::SubdomainRequired) do
    scope module: 'account' do
      root to: 'dashboard#index', as: :account_root
      get '/sign_in' => 'sessions#new'
      post '/sign_in' => 'sessions#create', as: :sessions
      get '/sign_up' => 'users#new', as: :user_sign_up
      post '/sign_up' => 'users#create', as: :do_user_sign_up
    end
  end
  root "dashboard#index"

  get '/sign_up' => 'accounts#new', as: :sign_up
  post '/accounts' => 'accounts#create', as: :accounts
end
