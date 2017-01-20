class InputBar < ActiveRecord::Base
  belongs_to :table_bar
  belongs_to :employee
  enum payment_method: { money: 0, visa_credit: 1, visa_debit: 2, master_credit: 3, master_debit: 4, dinners_credit: 5, dinners_debit: 6,
                          amex_credit: 7, amex_debit: 8, check: 9, elo_debit: 10, elo_credit: 11, bank_deposit: 12, credit_authorized: 13 }
  after_update :add_amount_from_cash_register, only: [:pay]
  enum status_t: { undone: false, ok: true }
  enum type_t: { sale: 0, purchase: 1 }

  def self.insert(table_id)
  	insertInput = InputBar.new(date_in: Time.current, table_bar_id: table_id)
  	if insertInput.save
      true
    end
  end

  def self.getInput(id)
  	InputBar.where(table_bar_id: id).last
  end

  def self.pay(id_order, payment, pricec, employee_id)
    @@price = pricec
    #duplicar na tabela transactions
    if self.duplicatet(id_order, employee_id, payment)
      InputBar.find(id_order).update(date_out: Time.current, payment_method: payment, employee_id: employee_id)
    end
  end

  def self.duplicatet(id_order, employee_id, payment)
    all_transactions_bar = TransactionBar.where(input_bar_id: id_order).where.not(status_t: :undone).all
    
    all_transactions_bar.each do |bar|
     

      @transaction_new = Transaction.new(type_t: 'sale',
      quantity: bar.quantity, product_code: bar.product_code, employee_id: employee_id, 
      payment_method: payment, data_t: bar.input_bar.date_in, price: bar.product.price * bar.quantity)
      Rails.logger.debug("My object: #{@transaction_new.inspect}")
      @transaction_new.save!

    end
    true
  end

  #Caso õ total seja 0 reais
  def self.destroyOrder(id_order)
    InputBar.find(id_order).destroy
  end

  private
  # GERENCIAR CAIXA
  def add_amount_from_cash_register
    if payment_method == "money"
      add_amount_to_cash_register
    end
  end

  def add_amount_to_cash_register
    CashRegister.add(@@price)
  end

end
