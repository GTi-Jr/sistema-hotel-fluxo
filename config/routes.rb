Rails.application.routes.draw do
 # default_url_options host: '138.197.19.102'
  
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
    get 'transactions/search' => 'transaction#search', as: :search_product
    put 'transactions/undo_last' => 'transaction#undo_last', as: :undo_last_transaction
    
    #bar
    get 'bar/table' => 'table_bar#show'
    get 'bar/close/:id' => 'table_bar#close', as: :close_table_bar
    get 'bar/options/:id' => 'table_bar#options', as: :options_table_bar
    post 'bar/transaction' => 'transaction_bar#save', as: :transaction_bar
    put 'transactions/undo_last_bar/:id' => 'transaction_bar#undo_last', as: :undo_last_transaction_bar
    post '/bar/pay' => 'table_bar#pay'
    get 'transactions/search_bar' => 'transaction_bar#search', as: :search_product_bar

    namespace :admin do
      resources :employees
    end
  end

  unauthenticated :employee do
   
  end

  root 'dashboard#index'


end
