Rails.application.routes.draw do
  namespace :site do
    get 'welcome/index'
    get 'search', to: 'search#questions'
    get 'subject/:subject_id', to: 'search#subject', as: 'search_subject'
    post 'answer', to: 'answer#question'
  end
  namespace :users_backoffice do
    get 'welcome/index'
  end
  namespace :admins_backoffice do
    get 'welcome/index' # Dashboard
    resources :admins # Administradores
    resources :subjects # Assuntos
    resources :questions # Perguntas
  end
  
  devise_for :users
  devise_for :admins

  get "inicio", to: "site/welcome#index"

  root "site/welcome#index"
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
