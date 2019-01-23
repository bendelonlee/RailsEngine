Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get "find", to: "searches#show"
      end
      resources :items, only: [:index, :show]
      resources :merchants, only: [:index, :show]
    end
  end
end
