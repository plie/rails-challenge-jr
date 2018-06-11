Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'messages#new'

  post '/', to: 'messages#create', as: :messages
  get '/:token/unlock', to: 'messages#unlock', as: :unlock
  get '/:token', to: 'messages#show', as: :display

end
