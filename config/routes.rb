Rails.application.routes.draw do
  root_to 'projects#index'
  resources :projects, only: [:index]
end
