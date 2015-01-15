Rails.application.routes.draw do
  
#   i guess this is reached with localhost:3000
  root 'static_pages#home'
  
  
  get  'static_pages/help'
  get  'static_pages/about'
  get  'static_pages/contact'
end