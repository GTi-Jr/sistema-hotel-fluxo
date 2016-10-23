class CreateTransactionns < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.boolean :type
      t.integer :payment_method
      t.string :client_code
      t.references :department, index: true, foreign_key: true
      t.references :sector, index: true, foreign_key: true
      t.decimal  "price", precision: 8, scale: 2, default: 0.0
      t.references :product, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
