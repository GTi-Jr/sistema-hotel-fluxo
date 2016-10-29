class Product < ActiveRecord::Base
  belongs_to :sector
  belongs_to :dapartment
end
