Rails.application.routes.draw do
  root to: 'projects#index'
  resources :projects, only: [:index]
  get '/search_projects' => 'projects#search_projects'
end
