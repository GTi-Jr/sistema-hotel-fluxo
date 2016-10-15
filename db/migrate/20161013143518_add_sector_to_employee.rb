class AddSectorToEmployee < ActiveRecord::Migration
  def change
    add_reference :employees, :sector, index: true, foreign_key: true
  end
end
