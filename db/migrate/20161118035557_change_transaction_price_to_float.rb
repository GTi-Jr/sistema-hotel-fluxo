class ChangeTransactionPriceToFloat < ActiveRecord::Migration
  def change
    remove_column :transactions, :price, :decimal
    add_column :transactions, :price, :float
  end
end
