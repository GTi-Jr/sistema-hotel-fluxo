class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :code
      t.string :name
      t.text :description
      t.decimal  "price", precision: 8, scale: 2, default: 0.0, default: nil
      t.references :sector, index: true, foreign_key: true
      t.references :department, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
