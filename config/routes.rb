Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  resources :users do
    member do
      get :password_edit
      patch :password_update
      get :confirm_destroy
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
end
