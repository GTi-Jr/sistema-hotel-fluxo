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

    case options[:type]
    when 1
      @transactions = transactions.where(type: 1)
    when 2
      @transactions = transactions.where(type: 0)
      # Caso seja todos, nao entrará em nenhum case e pegará todos
    end

    if options[:department].present?
      @transactions = transactions.where(department_id: options[:department])
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
