class AddStockToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :stock, :integer, default: 0
  end
end
