class ProductController < Admin::BaseController

  def index
  	code = params[:code]
  	unless  code.nil?
  		redirect_to find_product_path(code)
  	end


  end

  def find
  	@product = Product.find_by(code: params[:code])
    if @product.nil?
      redirect_to product_path, alert: 'Produto não encontrado.'
    end
  end

  
end
