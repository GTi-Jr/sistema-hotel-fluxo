# NÃO RODAR ESSE ARQUIVO APÓS ENTRAR EM PRODUÇÃO. **********************
Sector.create(name: 'Todos')
Department.create(name: 'Todos')
Product.create(name: 'Hospedagem', code: 001, type_t: 'sale')
Product.create(name: 'Alivio', code: 1000, type_t: 'sale')
Product.create(name: 'Suprimento', code: 2000, type_t: 'sale')
Employee.create(name: 'Admin GTI', email: 'admin@hotel.com', password: Rails.application.secrets.admin_email, sector_id: '1', department_id: '1', code: '123', admin: true)
# Inicializa o dinheiro em caixa

  CashRegister.initiate!

