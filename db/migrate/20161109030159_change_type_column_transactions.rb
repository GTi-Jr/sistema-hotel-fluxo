class ChangeTypeColumnTransactions < ActiveRecord::Migration
  def change
    remove_column :transactions, :type_t, :boolean
    add_column    :transactions, :type_t, :integer
  end
end
