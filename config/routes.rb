Rails.application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
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
      end
    end
  end
  
  authenticated :user, ->(u) { u.trader? } do
    root 'clients#dashboard', as: :client_dashboard
  end
 
  root to: 'home#index'
end
