class Transaction < ActiveRecord::Base
  belongs_to :product

  def value
    quantity * product.value
  end
end
