# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      # namespace :merchants do
      #   resources :find, only: [:index], controller: 'search'
      # end
      get 'merchants/find', to: 'merchant_search#show'
      resources :merchants, only: %i[index show] do
        resources :items, only: [:index], controller: 'merchant_items'
      end
      get 'items/find_all', to: 'items_search#show'
      resources :items do
        get '/merchant', to: 'merchants#show'
      end
    end
  end
end
