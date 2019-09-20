Rails.application.routes.draw do
  resources :visits do 
    collection { get :vacuum }
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
