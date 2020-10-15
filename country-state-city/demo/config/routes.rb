Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'

  # Auth
  resources :user_sessions, only: [:create, :index]
  get 'sign_in' => 'user_sessions#new', :as => :sign_in
  delete 'logout' => 'user_sessions#destroy', :as => :logout

  # Users
  resources :users

  # Contacts
  namespace :api do
    namespace :v1 do
      resources :contacts
    end
  end
end
