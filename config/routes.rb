Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "api/users#index"

  namespace :api, defaults: { format: :json } do
    resources :users
    resources :courses
  end
end
