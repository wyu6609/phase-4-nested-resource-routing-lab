Rails.application.routes.draw do
  resources :users, only: %i[show] do
    resources :items, only: %i[index show create]
  end

  resources :items, only: [:index]
end
