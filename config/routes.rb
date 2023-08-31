Rails.application.routes.draw do
  # get 'tasks/index'
  # get 'tasks/create'
  # get 'tasks/update'
  # get 'tasks/destroy'
  devise_for :users
  resources :tasks
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
