class Suggestion
  def self.main_query(options = {})
	  products_suggestions = Product.where(type_t: [Product.type_ts[options[:product_type_t].to_sym], Product.type_ts[:both]])
                                  .where("code LIKE ? OR name LIKE ?", "#{options[:queryString]}%", "#{options[:queryString]}%").limit(5)
	  
    products_suggestions.any? ? products_suggestions : false
  end
end

