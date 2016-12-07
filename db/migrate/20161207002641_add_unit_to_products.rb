class AddUnitToProducts < ActiveRecord::Migration
  def change
    add_column :products, :unit, :string
    add_column :products, :string, :string
  end
end
