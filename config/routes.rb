Rails.application.routes.draw do

  devise_for :users, controllers: {
  sessions: 'users/sessions', # Customize the session controller
  registrations: 'users/registrations', # Customize the registration controller
  # Add other controllers here as needed
}
  resources :projects 
  resources :project_users 
  resources :milestones
  resources :tasks

  root 'projects#index'
  
  devise_scope :user do
    get "users/sign_in", to: "devise/sessions#new"
    get 'users/sign_out', to: 'devise/sessions#destroy'
  end
  
  resources :users, only: [:show, :edit, :update]
end
