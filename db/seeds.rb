# NÃO RODAR ESSE ARQUIVO APÓS ENTRAR EM PRODUÇÃO. **********************
Sector.create(name: 'Todos')
Sector.create(name: 'Portaria')
Sector.create(name: 'Garçons')
Department.create(name: 'Todos')
Department.create(name: 'Cozinha')
Department.create(name: 'Recepçao')
Employee.create(name: 'Admin GTI', email: 'admin@hotel.com', password: ENV['ADMIN_PASSWORD'], sector_id: '1', department_id: '1', code: '123', admin: true)
# Inicializa o dinheiro em caixa
begin
  CashRegister.initiate!
rescue e
  e.message
end
