# NÃO RODAR ESSE ARQUIVO APÓS ENTRAR EM PRODUÇÃO. **********************
Employee.create(name: 'Admin GTI', email: 'admin@hotel.com', password: Rails.application.secrets.admin_email, sector_id: '1', department_id: '1', code: '123', admin: true)

(1..80).each do |i|
    TableBar.create(number: i, status: true)
end

# Inicializa o dinheiro em caixa
CashRegister.initiate!

