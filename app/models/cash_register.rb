class CashRegister
  class << self
    def add(quantity)
      self.amount += quantity
    end

    def remove(quantity)
      self.amount -= quantity
    end

    def amount
      MoneyFlowSettings.amount_inside_cash_register
    end

    def initiate!(options = {})
      options.reverse_merge!({ insecure: false })
      raise "You can't use this method if the cash register already has a value." if !options[:insecure] && !amount.nil?
      MoneyFlowSettings.amount_inside_cash_register = 0
    end

    private

    def amount=(quantity)
      MoneyFlowSettings.amount_inside_cash_register = quantity
    end
  end
end
