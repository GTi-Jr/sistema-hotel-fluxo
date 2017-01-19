class HistoryBarQuery
  def self.main_query(options = {})
  	@transactions_bar = TransactionBar.where(input_bar_id: options[:id_order]).order("input_bar_id DESC")
  end

  def self.inputs(options = {})
    reset_query_state
  	@inputs_bar = inputs_bar.where.not(date_out: :NULL).order("date_in DESC")
   
    if options[:date_range].present?
      initial_date = Time.parse("#{options[:date_range].split('-')[0]} 00:00:00")
      end_date     = Time.parse("#{options[:date_range].split('-')[1]} 23:59:59")
      @inputs_bar = inputs_bar.where(date_in: (initial_date..end_date))
    end

    if options[:tables].present?
      @inputs_bar = inputs_bar.includes(:table_bar).where(table_bars: { id: options[:tables] })
    end

    if options[:employee].present?
      @inputs_bar = inputs_bar.where(employee_id: options[:employee].to_i )
    end

    if options[:payment_method] == 'money'
      @inputs_bar = inputs_bar.where(payment_method: 0)
    elsif options[:payment_method] == 'visa_credit'
      @inputs_bar = inputs_bar.where(payment_method: 1)
    elsif options[:payment_method] == 'visa_debit'
      @inputs_bar = inputs_bar.where(payment_method: 2)
    elsif options[:payment_method] == 'master_credit'
      @inputs_bar = inputs_bar.where(payment_method: 3)
    elsif options[:payment_method] == 'master_debit'
      @inputs_bar = inputs_bar.where(payment_method: 4)
    elsif options[:payment_method] == 'dinners_credit'
      @inputs_bar = inputs_bar.where(payment_method: 5)
    elsif options[:payment_method] == 'dinners_debit'
      @inputs_bar = inputs_bar.where(payment_method: 6)
    elsif options[:payment_method] == 'amex_credit'
      @inputs_bar = inputs_bar.where(payment_method: 7)
    elsif options[:payment_method] == 'amex_debit'
      @inputs_bar = inputs_bar.where(payment_method: 8)
    elsif options[:payment_method] == 'check'
      @inputs_bar = inputs_bar.where(payment_method: 9)
    elsif options[:payment_method] == 'elo_debit'
      @inputs_bar = inputs_bar.where(payment_method: 10)
    elsif options[:payment_method] == 'elo_credit'
      @inputs_bar = inputs_bar.where(payment_method: 11)
    elsif options[:payment_method] == 'bank_deposit'
      @inputs_bar = inputs_bar.where(payment_method: 12)
    elsif options[:payment_method] == 'credit_authorized'
      @inputs_bar = inputs_bar.where(payment_method: 13)
    end

    

    @inputs_bar || InputBar.none

  end

  private

  def self.inputs_bar
    @inputs_bar || InputBar
  end

  def self.reset_query_state
    @inputs_bar = nil
  end


end