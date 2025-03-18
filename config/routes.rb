Rails.application.routes.draw do
  get 'welcome/index'
  get 'welcome/patient_demo', as: :patient_demo
  get 'welcome/doctor_demo'

  devise_for :patients
  devise_for :doctors

  match "/auth/:action/callback", to: "omniauth_callbacks", via: [:get, :post],
    constraints: { action: /facebook|humanapi/ }


  post "humanapi/notifications"
  post "welcome/contact_us", as: :contact_us
  get "welcome/get_otp", as: :get_otp

  get "relationship/:id/accept", to: "relationship#accept", as: :accept_relationship

  namespace :patients do
    get 'welcome/index', as: :dashboard
    get 'connect', to: "welcome#connect", as: :connect
    resources :patients
    resources :doctors
    resources :metrics, only: :index
    resources :chart_annotations, only: [:show, :create, :update]
  end

  namespace :doctors do
    resources :doctors
    resources :patients
    resources :emergencies
    resources :metrics, only: :index
    resources :chart_annotations, only: [:show, :create, :update]
    get 'welcome/index', as: :dashboard
  end

  root to: 'welcome#index'
end
