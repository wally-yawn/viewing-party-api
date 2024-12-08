Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :index]
      resources :sessions, only: :create
      namespace :top_movies do
        resources :search, only: :index
      end
      resources :top_movies, only: :index
      # resources :viewing_party, only: :create
      post "viewing_parties/:host_id", to: "viewing_parties#create"
      resources :movie, only: :show
    end
  end
end
