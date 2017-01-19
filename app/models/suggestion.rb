class Suggestion
  def self.main_query(options = {})
  	reset_query_state
    @suggestions = products.where(type_t: [Product.type_ts[options[:product_type_t].to_sym], Product.type_ts[:both]])
                                  .where("code LIKE ? OR name LIKE ?", "#{options[:queryString]}%", "#{options[:queryString]}%")
	if options[:isbar]=="true"
      @suggestions = products.where("sector_id = ? OR sector_id = ?", 2,3)
    end
    @suggestions.limit(15)  || Product.none
  end


  private

  def self.products
    @suggestions || Product
  end

  def self.reset_query_state
    @suggestions = nil
  end
end

