class CreateTransactionBars < ActiveRecord::Migration
  def change
    create_table :transaction_bars do |t|
      t.references :input_bar, index: true, foreign_key: true
      t.string :product_code
      t.integer :payment_method
      t.integer :quantity
      t.date :date_t
      t.timestamps null: false
    end
  end
end
