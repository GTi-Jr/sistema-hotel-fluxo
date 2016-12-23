class HistoryQuery
  def self.main_query(options = {})
    reset_query_state

    if options[:date_range].present?
      initial_date = Date.parse(options[:date_range].split('-')[0])
      end_date     = Date.parse(options[:date_range].split('-')[1])

      @transactions = transactions.where(data_t: (initial_date..end_date))
    end

    if options[:code].present?
      @transactions = transactions.includes(:product).where(products: { code: options[:code].to_i })
    end

    if options[:employee].present?
      @transactions = transactions.where(employee_id: options[:employee].to_i )
    end

    if options[:type_t] == "all"
      #NADA
    elsif options[:type_t] == "sales"
      @transactions = transactions.where(type_t: 0) # 0 sale
    elsif options[:type_t] == "purchases"
      @transactions = transactions.where(type_t: 1) # 0 sale
    end

    unless options[:department_id].to_i == 1 
      @transactions = transactions.includes(:product).where(products: { department_id: options[:department_id] } )
    end

    if options[:payment_method] == 'money'
      @transactions = transactions.where(payment_method: 0)
    elsif options[:payment_method] == 'visa_credit'
      @transactions = transactions.where(payment_method: 1)
    elsif options[:payment_method] == 'visa_debit'
      @transactions = transactions.where(payment_method: 2)
    elsif options[:payment_method] == 'master_credit'
      @transactions = transactions.where(payment_method: 3)
    elsif options[:payment_method] == 'master_debit'
      @transactions = transactions.where(payment_method: 4)
    elsif options[:payment_method] == 'dinners_credit'
      @transactions = transactions.where(payment_method: 5)
    elsif options[:payment_method] == 'dinners_debit'
      @transactions = transactions.where(payment_method: 6)
    elsif options[:payment_method] == 'amex_credit'
      @transactions = transactions.where(payment_method: 7)
    elsif options[:payment_method] == 'amex_debit'
      @transactions = transactions.where(payment_method: 8)
    elsif options[:payment_method] == 'check'
      @transactions = transactions.where(payment_method: 9)
    end

    @transactions || Transaction.none

  end

  private

  def self.transactions
    @transactions || Transaction
  end

  def self.reset_query_state
    @transactions = nil
  end
end
