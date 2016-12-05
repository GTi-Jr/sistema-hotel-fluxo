class TransactionController < BaseController
  def save
    @transaction = Transaction.main_query(
      code: params[:code],
      quantity: params[:quantity],
      type_t: params[:type],
      data_trans: params[:data_trans],
      client_code: params[:client_code],
      value: params[:value],
      employee: current_employee.id,
      payment_method: params[:payment_method]
    )

    if @transaction[:status] == true
      @stock = @transaction[:message]
      
      respond_to do |format|
        format.js { render json: [{"stock": @stock, "amount_cash": ActiveSupport::NumberHelper.number_to_currency(CashRegister.amount)}]  , status: 200 }
      end

    else
      respond_to do |format|
        format.js { render json: "<script>
                                   noty({text: ' #{@transaction[:message]}', layout: 'bottom', type: 'warning', timeout: 4000});
                                  </script>" }
      end
    end
  end

  def search
    @departments = Department.all
    @date = params[:date_range]
    @transactions = HistoryQuery.main_query(
      date_range: params[:date_range],
      end_date: params[:end_date],
      type_t: params[:type],
      code: params[:code],
      department_id: params[:departments],
      payment_method: params[:payment_method]
    )
  end

  def undo_last
    if current_employee.transactions.last.status_t ==  'undone'
      redirect_to :back, alert: 'Última transação já foi desfeita!'
    else
      Transaction.undo_last(current_employee)
      redirect_to :back, notice: 'Você desfez o último lançamento!'
    end
  end
end