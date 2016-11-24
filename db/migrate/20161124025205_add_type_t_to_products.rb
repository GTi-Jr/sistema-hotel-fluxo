class AddTypeTToProducts < ActiveRecord::Migration
  def change
    add_column :products, :type_t, :integer
  end
end
