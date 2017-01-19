class CreateTableBars < ActiveRecord::Migration
  def change
    create_table :table_bars do |t|
      t.integer :number
      t.boolean :status, default: false
      t.timestamps null: false
    end
    add_index :table_bars, :number, unique: true
  end
end
