class AddDepartmentToEmployee < ActiveRecord::Migration
  def change
    add_reference :employees, :department, index: true, foreign_key: true
  end
end
