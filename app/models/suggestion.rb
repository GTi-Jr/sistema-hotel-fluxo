class Suggestion
  def self.main_query(options = {})
  	  product_suggestion = Product.where("code LIKE ? OR name LIKE ?", "#{options[:queryString]}%", "#{options[:queryString]}%").limit(5)
  	  if product_suggestion.any?
  	  	product_suggestion
  	  else
  	  	false
  	  end

  end
end


