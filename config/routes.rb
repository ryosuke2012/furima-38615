Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'personalities', to: 'users/registrations#new_personality'
    post 'personalities', to: 'users/registrations#create_personality'
  end
  root to: "items#index"
  resources :items do
    resources :orders, only: [:index, :create]
  end
end