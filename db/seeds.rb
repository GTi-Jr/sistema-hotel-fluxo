# NÃO RODAR ESSE ARQUIVO APÓS ENTRAR EM PRODUÇÃO. **********************
Employee.create(name: 'Admin GTI', email: 'admin@hotel.com', password: ENV['ADMIN_PASSWORD'], sector_id: '1', department_id: '1', code: '123', admin: true)
# Inicializa o dinheiro em caixa
MoneyFlowSettings.amount_inside_cash_register = 0
