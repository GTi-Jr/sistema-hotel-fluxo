module TransactionBarHelper
	#@param: input_bar_id
	def total_bar(input_bar_id)
	  total = 0
  	  TransactionBar.products_order(input_bar_id).each do |sum|
        total += sum.product.price * sum.quantity
  	  end
  	  total.round(2)
	end
end
