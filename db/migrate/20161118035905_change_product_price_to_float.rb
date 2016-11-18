class ChangeProductPriceToFloat < ActiveRecord::Migration
  def change
    remove_column :products, :price, :decimal
    add_column :products, :price, :float
  end
end
