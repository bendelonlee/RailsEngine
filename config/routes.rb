Rails.application.routes.draw do
  namespace :merchants do
    get "find", to: "searches#show"
  end
  resources :items, only: [:index, :show]
  resources :merchants, only: [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
