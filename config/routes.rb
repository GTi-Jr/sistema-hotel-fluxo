Rails.application.routes.draw do

  namespace :admin do
    resources :employees
  end

  
  devise_for :employees, controllers: {
    sessions: 'employees/sessions',
    confirmations: 'employees/confirmations',
    passwords: 'employees/passwords',
    registrations:'employees/registrations'
  },
  path: '',
  path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    password: 'secret',
    confirmation: 'verification',
    unlock: 'unblock',
    registration: 'registration',
    sign_up: 'new'
  } , skip: [:registrations]
  
  authenticated :employee do

    get 'product/:code', to: 'product#find', as: :find_product
    get 'product' => 'product#index'
    get 'products/search' => 'product#search', as: :search_product
    post 'product/transaction' => 'product#transaction', as: :transaction
  end

  unauthenticated :employee do
   
  end
  root 'dashboard#index'

end
