class Product < ActiveRecord::Base
  belongs_to :sector
  belongs_to :department

  enum type_t: { sale: 0, purchase: 1, both: 2 }
end
