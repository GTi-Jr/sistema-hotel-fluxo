Rails.application.routes.draw do

  root 'dashboard#index'


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
    root 'dashboard#index', as: :authenticated_employee_root
  end

  unauthenticated :employee do
    root 'dashboard#index',  as: :unauthenticated_employee_root
  end

end
