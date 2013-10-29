Subscribem::Engine.routes.draw do
  require 'subscribem/constraints/subdomain_required'

  constraints(Subscribem::Constraints::SubdomainRequired) do
    scope module: 'account' do
      root to: 'dashboard#index', as: :account_root
      get '/sign_in' => 'sessions#new'
      post '/sign_in' => 'sessions#create', as: :sessions
    end
  end
  root "dashboard#index"

  get '/sign_up' => 'accounts#new', as: :sign_up
  post '/accounts' => 'accounts#create', as: :accounts
end
