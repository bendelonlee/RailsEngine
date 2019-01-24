Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get "find", to: "search#show"
        get "find_all", to: "search#index"
        get ":id/items", to: "items#index"
        get "most_revenue", to: "revenue#index"
        get ":id/revenue", to: "revenue#show"
      end
      resources :items, only: [:index, :show]
      resources :merchants, only: [:index, :show]
    end
  end
end
