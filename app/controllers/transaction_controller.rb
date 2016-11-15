class TransactionController < BaseController


	def save
		@transaction = Transaction.main_query(
		 	code: params[:code],
			quantity: params[:quantity],
			type_t: params[:type],
			data_trans: params[:data_trans],
			client_code: params[:client_code],
			value: params[:value],
			employee: current_employee.id
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

  def destroy
  	transaction_d = Transaction.find(params[:id]).update(status_t: 0)
  	redirect_to product_path, notice: 'Feito! Você desfez a sua última ação.'
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


end
