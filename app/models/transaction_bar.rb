class TransactionBar < ActiveRecord::Base
  belongs_to :input_bar
  belongs_to :employee
  belongs_to :product, foreign_key: 'product_code', primary_key: 'code'

  after_create :update_stock

  validates_presence_of :product_code, :date_t
  validates :quantity, numericality: { greater_than: 0 }
  enum status_t: { undone: false, ok: true }

  def self.products_order(id_order)
  	TransactionBar.where(input_bar_id: id_order).where.not(status_t: :undone).order("created_at DESC")
  end


  def self.main_query(options = {})
  	@last_order_table = InputBar.getInput(options[:table_bar_id])
    @transaction_new_bar = TransactionBar.new(quantity: options[:quantity], 
    									      product_code: options[:code],
    									      date_t: options[:data_trans], 
    									      input_bar_id: @last_order_table.id)
    if @transaction_new_bar.save
      #salvar na tabela de transac
      return {status: true}
    else
      message_erro = ""
      @transaction_new_bar.errors.full_messages.each do |message| 
        message_erro += "<li>#{message}</li>"
      end 
        return {status: false, message: "Erro ao salvar. Verifique se você preencheu todos os campos necessários corretamente.</br><ul>#{message_erro}</ul>"}
    end
  end


  def self.undo_last(id_order)
    transactionbar = TransactionBar.where(input_bar_id: id_order).last
    ProductStock.add(transactionbar.product_code, transactionbar.quantity)
    transactionbar.update(status_t: 'undone')
  end

  #GERENCIAR ESTOQUE
  def update_stock
    remove_to_stock
  end

  def remove_to_stock
    ProductStock.remove(product_code, quantity)
  end




end
