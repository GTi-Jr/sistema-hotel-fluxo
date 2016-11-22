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
			@id_create = @transaction[:message]
			#render '/product/transaction' , layout: false
			render html: "tudo_ok".html_safe
		else
			render html: "<script>
			noty({text: ' #{@transaction[:message]}', layout: 'bottom', type: 'warning', timeout: 4000});
			</script>".html_safe  	
    end
  end

  def search
  	@departments = Department.all
  	@initial_date = params[:initial_date]
  	@end_date = params[:end_date]
  	@transactions = HistoryQuery.main_query(
			date_range: params[:date_range],
  		end_date: params[:end_date],
  		type_t: params[:type],
  		code: params[:code],
  		department_id: params[:department]
		)
  end

  def undo_last
    if Transaction.last.status_t ==  'undone'
      redirect_to :back, alert: 'Última transação já foi desfeita!'
    else
      Transaction.undo_last
      redirect_to :back, notice: 'Você desfez o último lançamento!'
    end
  end
end
