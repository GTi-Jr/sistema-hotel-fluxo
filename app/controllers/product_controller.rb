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
    @transactions = Transaction.where.not(status_t: :undone).order('data_t DESC, id DESC').paginate(page: params[:page], per_page: 10)
  end

  def suggestion
    @product_suggestion = Suggestion.main_query(queryString: params[:queryString].strip)

    if @product_suggestion==false  ||  params[:queryString].strip == ""
       render html: ('<ul><li>Nada encontrado.</li></ul>').html_safe
    else
        texto = "<ul id=\"ulSugest\">"
        @product_suggestion.each do |product_list| 
         texto += "<li onClick=\"fill(\'#{product_list.code} \' ,\'#{product_list.price}\', \'#{product_list.name}\');\">#{product_list.code} - #{product_list.name}</li>"
        end
        texto += "</ul>"
        render html: (texto).html_safe
    end
  
  end


  private
    def set_product_type
      @product = Product.find_by(code: params[:code])
    end
   
end
