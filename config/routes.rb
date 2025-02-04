Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :items do
        match 'find_all', via: %i[get], as: :find_all, on: :collection
        match 'find', via: %i[get], as: :find, on: :collection
        resource :merchants, only: %i[show], controller: 'items/merchants'
      end
      resources :merchants do
        match 'find_all', via: %i[get], as: :find_all, on: :collection
        match 'find', via: %i[get], as: :find, on: :collection
        resources :items, only: %i[index], controller: 'merchants/items'
        match 'most_revenue', via: %i[get], as: :most_revenue, on: :collection, controller: 'merchants/business_intelligence'
      end
    end
  end
end
