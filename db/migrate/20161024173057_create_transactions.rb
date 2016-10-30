class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.boolean :type_t
      t.integer :payment_method
      t.integer :quantity
      t.string :client_code
      t.date :data_t
      t.references :employee, index: true, foreign_key: true
      #1 para "PUBLICADO " 0  para "DESFEITO"
      t.boolean :status_t, default: 1
      t.decimal  "price", precision: 8, scale: 2, default: 0.0
      t.integer :product_code
      t.timestamps null: false
    end
  end
end