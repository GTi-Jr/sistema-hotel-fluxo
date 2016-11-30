class Transaction < ApplicationRecord
  belongs_to :product, foreign_key: 'product_code', primary_key: 'code'
  belongs_to :employee

  before_create :set_price
  before_create :add_or_remove_amount_from_cash_register

  enum type_t: { sale: 0, purchase: 1 }
  enum status_t: { undone: false, ok: true }
  enum payment_method: { money: 0, visa_credit: 1, visa_debit: 2, master_credit: 3, master_debit: 4, dinners_credit: 5, dinners_debit: 6,
                          amex_credit: 7, amex_debit: 8, check: 9 }

  def self.main_query(options = {})
    #VERIFICAR SE É HOSPEDAGEM
    product_hospedagem_code = Product.find_by(name: 'Hospedagem').code
    if product_hospedagem_code==options[:code].to_i
        #verifica sem o campo code_client e price não está vazio
        if options[:client_code].blank? || options[:value].blank?
          return {status: false, message: "Parece que você não preencheu alguns campos obrigatórios."}
        end
    end
    
    if options[:code].blank?
      return {status: false, message: "Parece que você não preencheu alguns campos obrigatórios."}
    end

    #salvar dados
    @transaction_new = Transaction.new(
      type_t: options[:type_t],
      quantity: options[:quantity], client_code:options[:client_code],
      price: options[:value], product_code: options[:code],employee_id: options[:employee], data_t: options[:data_trans],
      payment_method: options[:payment_method]
    )
    
    if @transaction_new.save!
      return {status: true, message: @transaction_new.id}
    else
      return {status: false, message: "Erro S."}
    end
  end

  def sale?
    type_t == 'sale'
  end

  def set_price
    unless product.name == 'Hospedagem'
      self.price = quantity * product.price
    end
  end

  def self.undo_last 
    last.update(status_t: :undone)
  end

  def self.payment_method_options
    payment_methods.map { |payment_method, _|
      [I18n.t("activerecord.attributes.#{model_name.i18n_key}.payment_methods.#{payment_method}"), payment_method]}
  end

  private 

  def add_or_remove_amount_from_cash_register
    sale? ? add_amount_to_cash_register : remove_amount_from_cash_register
  end

  def add_amount_to_cash_register
    CashRegister.add(price)
  end

  def remove_amount_from_cash_register
    CashRegister.remove(price)
  end
end
