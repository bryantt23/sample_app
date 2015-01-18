Rails.application.routes.draw do
  
  
  # root method arranges for the root path / to be routed to a 
  # controller and action of our choice

  # also allows us to refer to routes by a name rather than by the raw URL
  
#   i guess this is reached with localhost:3000
  root 'static_pages#home'
  
  
  # routes a GET request for the URL /help to the help action in the 
  # Static Pages controller, so that we can use the URL /help in place of the 
  # more verbose /static_pages/help  
  
  # get  'static_pages/help'  
  get 'help'    => 'static_pages#help'
  
  
  get 'about'   => 'static_pages#about'
  get 'contact' => 'static_pages#contact'

end
