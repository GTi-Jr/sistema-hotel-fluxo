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

  def search
    @departments = Department.all
    @histories = HistoryQuery.main_query(initial_date: params[:initial_date], 
                                         end_date: params[:end_date],
                                         type: params[:type],
                                         code: params[:code],
                                         department: params[:department])
  end
end
