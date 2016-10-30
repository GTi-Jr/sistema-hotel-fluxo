class HistoryQuery

  def self.main_query(options = {})
    @transactions = Transaction.where("transactions.created_at BETWEEN ? AND ?", options[:initial_date], options[:end_date])

    if !options[:code].nil?
      @transactions =  @transactions.includes(:product).where(products: { code: options[:code]})
    end

    case options[:type]
    when 1
      @transactions = @transactions.where(type: 1)
    when 2
      @transactions = @transactions.where(type: 0)
    end

    if !options[:department].nil?
      @transactions = @transactions.where(department_id: options[:department])
    end


    @transactions

  end


end