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
      namespace :customers do
        get ":id/favorite_merchant", to: "favorite_merchants#show"
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
        get "invoices", to: "invoices#index"
      end
      resources :customers, only: [:index, :show], module: :customers do
        get "invoices", to: "invoices#index"
        get "transactions", to: "transactions#index"
      end
      resources :items, only: [:index, :show], module: :items do
        get "invoice_items", to: "invoice_items#index"
        get "merchant", to: "merchants#show"
      end
      resources :invoices, only: [:index, :show], module: :invoices do
        get "transactions", to: "transactions#index"
        get "items", to: "items#index"
        get "invoice_items", to: "invoice_items#index"
        get "customer", to: "customers#show"
        get "merchant", to: "merchants#show"
      end
      resources :invoice_items, only: [:index, :show], module: :invoice_items do
        get "invoice", to: "invoices#show"
        get "item", to: "items#show"
      end
      resources :transactions, only: [:index, :show], module: :transactions do
        get "invoice", to: "invoices#show"
      end
    end
  end
end
