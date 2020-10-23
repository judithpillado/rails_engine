Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :merchants do
        get 'items', to: 'merchants/items#index'
      end

      resources :items
    end
  end
end
