Rails.application.routes.draw do
  namespace :api do

    resource :profile, only: [:create,:show, :update, :destroy] do
      resource :avatar, only: [:create, :destroy]
    end

    resources :users, only: [:show, :index] do
      resources :user_ratings, only: [:index]
    end

    resources :places, only: [:show, :index] do
      resource :place_user, only: [:create]

      resources :user_ratings, only: [:index]

      resources :events, only: [:index]
    end

    resource :session, only: [:create, :destroy]

    resources :events, only: [:create, :index, :update, :destroy]
  end
end
