class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.date :date
      t.time :time
      t.integer :type
      t.integer :payment_method
      t.string :client_code
      t.integer :department_id
      t.integer :employee_id

      t.timestamps null: false
    end
  end
end
