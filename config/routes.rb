Rails.application.routes.draw do

  root 'claims#new', as: 'SubmitClaims'

  resources :claims, only: [:new, :create, :index] do
    collection { post :import }
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
