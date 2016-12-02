class ProductStock
  class << self
  	def add(product_code, quantity)
  	  Product.find_by(code: product_code).increment!(:stock, quantity)
  	end

  	def remove(product_code, quantity)
  	  Product.find_by(code: product_code).decrement!(:stock, quantity)
  	end

  	def view_stock(product_code)
  	  Product.find_by(code: product_code).stock
  	end

  	def subtract(product_code, quantity)
  	  self.view_stock(product_code).to_i - quantity.to_i #venda
  	end

  	def sum(product_code, quantity)
  	  self.view_stock(product_code).to_i + quantity.to_i #compra
  	end

  end
end