class TableBarController < BaseController
  before_action :open_table_bar, only: [:close,:options,:pay]
  before_action :check_bar_rights
  before_action :info_table_close, only: [:close,:pay]

  def show
    @TableBar = TableBar.all.order("number ASC")
  end

  def close
  	@money_amount_in_cash_register = CashRegister.amount
  	if @TableBar.status==true   #Se a mesa estiver aberta...
  	  @TableBar.update(status:false) #fechar
  	  InputBar.insert(@TableBar.id) #Inserir Order
  	  redirect_to close_table_bar_path, notice: "Mesa #{@TableBar.number} fechada com sucesso." 
  	end
  end

  def info_table_close
  	if @TableBar.status==false
  	  @find_input = InputBar.getInput(@TableBar.id) #get order
  	  @all_products_table = TransactionBar.products_order(@find_input.id)
  	  @total = sumAllProcuts
  	end
  end

  def pay
  	if @total!=0
  		if(params[:price_pago].to_f>=@total.round(2))
  		  flash[:notice] ="Troco: R$ #{(params[:price_pago].to_f-@total).round(2)}"
        duplicateTransaction
  		  InputBar.pay(@find_input.id, params[:payment_method], @total.round(2), current_employee.id)
  		  @TableBar.update(status:true)
  		  render json: [status:true]
  		else
  	  	  render json: [status:false, msg:"Não foi possivél concluir.</br>Ainda faltam R$ #{(@total-params[:price_pago].to_f).round(2)}"]  , status: 200
  		end
    else
      #Caso não tenha nenhum produto cadastrado
  		InputBar.destroyOrder(@find_input.id)
  		@TableBar.update(status:true)
  	  render json: [status:true]
  	end
  end

  def sumAllProcuts
  	total = 0
  	@all_products_table.each do |sum|
      total += sum.product.price * sum.quantity
  	end
  	total
  end

  def duplicateTransaction
    @all_products_table.each do |sum|
      #insert
      
    end
  end

  def options
  	#se a mesa estiver fechada...
  	if @TableBar.status==false
  		redirect_to close_table_bar_path
  	end
  end

  private

  def open_table_bar
    @TableBar = TableBar.find(params[:id])
  end

end
