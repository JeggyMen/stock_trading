Rails.application.routes.draw do
  get 'stocks/index'
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  resources :stocks, only: [:index] do
    member do
      post :add_to_portfolio
      post :buy
      post :sell
    end
  end

  get 'home/index'
  devise_for :users, controllers: { sessions: 'users/sessions' }

  authenticated :user, ->(u) { u.admin? } do
    namespace :admin do
      get 'dashboard', to: 'dashboards#index', as: :authenticated_root
      resources :users do
        member do
          get :approve
        end
        collection do
          get :pending
        end
      end
      resources :transactions, only: [:index]  
    end
  end
  
  authenticated :user, ->(u) { u.trader? && u.approved? } do
    root 'clients#dashboard', as: :client_dashboard
    resources :transactions, only: [:index]  
  end

  get 'pending_approval', to: 'traders#pending_approval', as: :pending_approval
  get 'clients/history', to: 'clients#history', as: 'clients_history'

  root to: 'home#index'
end
