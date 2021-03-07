Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  resources :planets, except: %i[create destroy]
  resources :weather, only: %i[index show]
end
