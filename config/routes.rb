Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get "most_revenue", to: "revenue#index"
        get "revenue", to: "revenue_by_date#index"
        get ":id/revenue", to: "revenue_by_date#show", constraints: { query_string: /date.+/ }
        get ":id/revenue", to: "revenue#show"
        get "most_items", to: "merchants_by_most_items#index"
        get ":id/favorite_customer", to: "customer_intelligence#show"
      end
      namespace :items do
        get "most_revenue", to: "revenue#index"
        get "most_items", to: "quantity#index"
        get ":id/best_day", to: "best_day#show"
      end
      ob_name = [:merchants, :customers, :items, :invoices, :invoice_items, :transactions]
      ob_name.each do |ob_name|
        namespace ob_name do
          get "find", to: "search#show"
          get "find_all", to: "search#index"
        end
      end
      resources :merchants, only: [:index, :show], module: :merchants do
        get "items", to: "items#index"
      end
      resources :customers, only: [:index, :show], module: :customers do
        get "invoices", to: "invoices#index"
        get "transactions", to: "transactions#index"
      end
      resources :items, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
      resources :transactions, only: [:index, :show]
    end
  end
end
