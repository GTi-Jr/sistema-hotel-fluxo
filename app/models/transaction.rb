class Transaction < ApplicationRecord
  belongs_to :product, foreign_key: 'product_code', primary_key: 'code'
  belongs_to :employee

  before_create :set_price
  before_create :add_or_remove_amount_from_cash_register
  after_create :update_stock

  validates_presence_of :price, :product_code, :payment_method, :type_t, :data_t
  validates :quantity, numericality: { greater_than: 0 }
  validates :client_code, presence: true, if: :client_code_host?


  enum type_t: { sale: 0, purchase: 1 }
  enum status_t: { undone: false, ok: true }
  enum payment_method: { money: 0, visa_credit: 1, visa_debit: 2, master_credit: 3, master_debit: 4, dinners_credit: 5, dinners_debit: 6,
                          amex_credit: 7, amex_debit: 8, check: 9 }



  def self.main_query(options = {})
    #BUSCAR ESTOQUE DO PRODUTO
    stock_prod = options[:type_t]=='sale' ? ProductStock.subtract(options[:code],options[:quantity]) : ProductStock.sum(options[:code],options[:quantity])

    @transaction_new = Transaction.new(type_t: options[:type_t],
      quantity: options[:quantity], client_code:options[:client_code],
      price: options[:value], product_code: options[:code],employee_id: options[:employee], data_t: options[:data_trans],
      payment_method: options[:payment_method], stock: stock_prod
    )
    if @transaction_new.save
      return {status: true, message: ProductStock.view_stock(options[:code])}
    else
      message_erro = ""
      @transaction_new.errors.full_messages.each do |message| 
        message_erro += "<li>#{message}</li>"
      end 
      return {status: false, message: "Erro ao salvar. Verifique se você preencheu todos os campos necessários corretamente.</br><ul>#{message_erro}</ul>"}
    end
    
  end

  def client_code_host?
    product_hospedagem_code = Product.find_by(name: 'Hospedagem').code
    if product_hospedagem_code == product_code
      true
    end
  end


  def sale?
    type_t == 'sale'
  end



  def set_price
    unless product.name == 'Hospedagem' || product.name == 'Suprimento' || product.name == 'Alivio'
      self.price = (quantity.to_i * product.price.to_f)
    end
  end

  def self.undo_last(employee)
    transaction = employee.transactions.last
    if transaction.sale?
      ProductStock.add(transaction.product_code, transaction.quantity)
      if transaction.payment_method == 'money'
       CashRegister.remove(transaction.price)
     end
    else
      ProductStock.remove(transaction.product_code, transaction.quantity)
      if transaction.payment_method == 'money'
        CashRegister.add(transaction.price)
      end
    end

    transaction.update(status_t: 'undone')
  end

  def self.payment_method_options
    payment_methods.map { |payment_method, _|
      [I18n.t("activerecord.attributes.#{model_name.i18n_key}.payment_methods.#{payment_method}"), payment_method]}
  end

  private 
  # GERENCIAR CAIXA
  def add_or_remove_amount_from_cash_register
    if payment_method == "money"
      sale? ? add_amount_to_cash_register : remove_amount_from_cash_register
    end
  end

  def add_amount_to_cash_register
    CashRegister.add(price)
  end

  def remove_amount_from_cash_register
    CashRegister.remove(price)
  end

  #GERENCIAR ESTOQUE
  def update_stock
    purchase? ? add_to_stock : remove_to_stock
  end

  def add_to_stock
    ProductStock.add(product_code, quantity)
  end

  def remove_to_stock
    ProductStock.remove(product_code, quantity)
  end
end

