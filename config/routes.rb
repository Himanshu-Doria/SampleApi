require 'api_constraints'

SampleApi::Application.routes.draw do  
  namespace :api do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, only: [:show,:create,:update,:destroy]
      resources :sessions, only: [:create,:destroy]
    end

    scope module: :v2, constraints: ApiConstraints.new(version: 2) do
        resources :users, only: [:show,:create,:update,:destroy]
        resource :sessions, only:[:create,:destroy]
    end
  end
end
