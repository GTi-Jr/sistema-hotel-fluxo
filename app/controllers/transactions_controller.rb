class TransactionsController < Admin::BaseController


  def search
     @departments = Department.all

    @initial_date = params[:initial_date]
    @end_date = params[:end_date]
    @transactions = HistoryQuery.main_query(initial_date: params[:initial_date], 
                                         end_date: params[:end_date],
                                         type: params[:type],
                                         code: params[:code],
                                         department: params[:department])
  end
end
