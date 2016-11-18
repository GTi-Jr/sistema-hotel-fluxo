Rails.application.routes.draw do
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
    get 'product' => 'product#index'
    get 'product/type/:type' => 'product#find', as: :type_product
    post 'product/suggestion' => 'product#suggestion'
    


    post 'product/transaction' => 'transaction#save', as: :transaction
    post 'product/transaction/:id' => 'transaction#destroy', as: :transaction_desfazer

    get 'transactions/search' => 'transaction#search', as: :search_product
    put 'transactions/undo_last' => 'transaction#undo_last', as: :undo_last_transaction
    namespace :admin do
      resources :employees
    end
  end

  unauthenticated :employee do
   
  end

  root 'dashboard#index'


end
