class AddPaymentMethodToInputBar < ActiveRecord::Migration
  def change
  	add_column :input_bars, :payment_method, :integer
  end
end
