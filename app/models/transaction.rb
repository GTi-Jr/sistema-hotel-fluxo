class Transaction < ActiveRecord::Base
  belongs_to :product, foreign_key: 'product_code', primary_key: 'code'
  belongs_to :employee

  enum type_t: { sale: 0, purchase: 1 }

  def self.main_query(options = {})
      #VERIFICAR SE É HOSPEDAGEM
      product_hospedagem_code = Product.find_by(name: 'Hospedagem').code
      if product_hospedagem_code==options[:code].to_i
          #verifica sem o campo code_client e price não está vazio
          if options[:client_code].blank? || options[:value].blank?
        return {status: false, message: "Parece que você não preencheu alguns campos obrigatórios."}
      end
    end

    #salvar dados
    @transaction_new = Transaction.new(type_t: options[:type_t],
     quantity: options[:quantity], client_code:options[:client_code],
     price: options[:value], product_code: options[:code],employee_id: options[:employee], data_t: options[:data_trans])
    if @transaction_new.save!
      return {status: true, message: @transaction_new.id}
    else
      return {status: false, message: "Erro S."}
    end
  end
end
