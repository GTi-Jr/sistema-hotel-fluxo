class TransactionBarController < BaseController
  before_action :check_bar_rights
  def save
    @transaction_bar = TransactionBar.main_query(
      code: params[:code],
      quantity: params[:quantity],
      data_trans: params[:data_trans],
      table_bar_id: params[:table_bar_id]
    )

    if @transaction_bar[:status] == true
      
      respond_to do |format|
        format.js { render json: [{status:true}]  , status: 200 }
      end

    else
      respond_to do |format|
        format.js { render json: "<script>
                                   noty({text: ' #{@transaction_bar[:message]}', layout: 'bottom', type: 'warning', timeout: 4000});
                                  </script>" }
      end
    end
  end

  def search
    #@transactions_bar = HistoryBarQuery.main_query
    @employees = Employee.all
    @tables = TableBar.all
    @date = params[:date_range]
    @inputsbar = HistoryBarQuery.inputs(date_range: @date, tables: params[:tables], payment_method: params[:payment_method], employee: params[:employee])
  end


  def undo_last
    if TransactionBar.where(input_bar_id: params[:id]).last.status_t ==  'undone'
      redirect_to :back, alert: 'Última transação já foi desfeita!'
    else
      TransactionBar.undo_last(params[:id])
      redirect_to :back, notice: 'Você desfez o último lançamento!'
    end
  end

end
