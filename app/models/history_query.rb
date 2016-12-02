class HistoryQuery  < ApplicationRecord
  enum payment_method: { money: 0, visa_credit: 1, visa_debit: 2, master_credit: 3, master_debit: 4, dinners_credit: 5, dinners_debit: 6,
                          amex_credit: 7, amex_debit: 8, check: 9 }

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

    if options[:type_t] == "all"
      #NADA
    elsif options[:type_t] == "sales"
      @transactions = transactions.where(type_t: 0) # 0 sale
    elsif options[:type_t] == "purchases"
      @transactions = transactions.where(type_t: 1) # 0 sale
    end

    if options[:department_id].present?
      @transactions = transactions.includes(:product).where(products: { department_id: options[:department_id] } )
    end

    unless options[:credit_card].blank?
      @transactions = transactions.where(payment_method: options[:credit_card])
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
