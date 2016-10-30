class ProductController < BaseController
  before_action :set_product_type, only: [:find]
  def index
  	code = params[:code]
  	unless code.blank? 
  		redirect_to find_product_path(code)
  	end

  end

  def find
    if @product.nil?
      redirect_to product_path, alert: 'Produto não encontrado.'
    end
    #RETORNAR CODIGO DO SERVIÇO HOSPEDAGEM
    @product_hospedagem_code = Product.find_by(name: 'Hospedagem').code
  end

  
  private
    def set_product_type
      @product = Product.find_by(code: params[:code])
    end
   
end
