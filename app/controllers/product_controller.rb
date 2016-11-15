class ProductController < BaseController
  before_action :set_product_type, only: [:find]
  def index
  	code = params[:code]
  	unless code.blank? 
  		redirect_to find_product_path(code)
  	end

  end

  def find
    @type = params[:type]

    if @type!='sale' &&  @type!='purchase'
      redirect_to product_path, alert: 'Tipo de lançamento não encontrado.'
    end

    #RETORNAR CODIGO DO SERVIÇO HOSPEDAGEM
    @product_hospedagem_code = Product.find_by(name: 'Hospedagem').code
  end

  def suggestion


    @product_suggestion = Suggestion.main_query(queryString: params[:queryString])

    render html: ('<ul id="ulSugest"><li onClick="fill(\'teste\');">'+params[:queryString] +'</li></ul>').html_safe
  end


  private
    def set_product_type
      @product = Product.find_by(code: params[:code])
    end
   
end
