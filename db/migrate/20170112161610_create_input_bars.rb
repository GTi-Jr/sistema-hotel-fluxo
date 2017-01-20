class CreateInputBars < ActiveRecord::Migration
  def change
    create_table :input_bars do |t|
      t.datetime :date_in
      t.datetime :date_out
      t.references :table_bar, index: true, foreign_key: true
      t.references :employee, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
