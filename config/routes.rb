Rails.application.routes.draw do
  get 'home/index'
  devise_for :users, controllers: { sessions: 'users/sessions' }

 
  authenticated :user, lambda { |u| u.admin? } do
    root 'admins#dashboard', as: :admin_authenticated_root

    namespace :admin do
      get 'dashboard', to: 'dashboards#index', as: 'dashboard'
      resources :users 
    end
  end
  
  authenticated :user, lambda { |u| u.trader? } do
    root 'clients#dashboard', as: :client_dashboard
  end

 
  root to: 'home#index'
end
