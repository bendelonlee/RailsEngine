Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get "find", to: "search#show"
        get "find_all", to: "search#index"
        get ":id/items", to: "items#index"
        get "most_revenue", to: "revenue#index"
        get "revenue", to: "revenue_by_date#index"
        get ":id/revenue", to: "revenue_by_date#show", constraints: { query_string: /date.+/ }
        get ":id/revenue", to: "revenue#show"
        get "most_items", to: "merchants_by_most_items#index"
        get ":id/favorite_customer", to: "customer_intelligence#show"
      end
      resources :items, only: [:index, :show]
      resources :merchants, only: [:index, :show]
    end
  end
end
