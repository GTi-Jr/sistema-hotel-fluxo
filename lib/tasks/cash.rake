namespace :dbc do
  task :initcash => :environment do
    CashRegister.initiate! insecure: true
  end
end