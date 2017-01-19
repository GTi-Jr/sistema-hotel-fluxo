class RemovePaymentMethodFromTransactionBar < ActiveRecord::Migration
  def change
  	 remove_column :transaction_bars, :payment_method, :integer
  end
end
