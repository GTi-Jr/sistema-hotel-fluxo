class AddStatusTToTransactionBar < ActiveRecord::Migration
  def change
  	add_column :transaction_bars, :status_t, :boolean, default: true
  end
end
