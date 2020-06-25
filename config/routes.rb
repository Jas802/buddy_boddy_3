Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "application#home"
  resources :users, only: [:new, :create, :show] do
    resources :workouts, only: [:index, :show]
  end
  resources :trainers, only:[:new, :create, :index, :show] do
    resources :workouts, only: [:index, :new, :create, :show, :edit, :update]
  end
  resources :workouts, only: [:index, :show, :create, :edit, :update]
  post '/workouts/add_to_workouts/:workout_id', to: 'workouts#add_to_workouts'
  delete 'workout/:id/delete', to: 'workouts#destroy', as: :delete
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get '/welcome', to: 'welcome#home'
  delete 'session/delete', to: 'sessions#delete', as: :logout 
  get "/auth/github/callback" => "sessions#create_from_github"
end