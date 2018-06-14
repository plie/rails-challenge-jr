Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'messages#new'

  get 'messages', to: 'messages#new'
  post 'messages', to: 'messages#create'
  get '/:token/:password', to: 'messages#show'
end
