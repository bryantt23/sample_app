Rails.application.routes.draw do
  root                'static_pages#home'
  get    'help'    => 'static_pages#help'
  get    'about'   => 'static_pages#about'
  get    'contact' => 'static_pages#contact'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  
  resources :users
  
# activation email will involve a URL of the form
# edit_account_activation_url(activation_token, ...)
# which means we’ll need a named route for the edit action  
resources :account_activations, only: [:edit]
end