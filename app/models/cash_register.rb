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

    private

    def amount=(quantity)
      MoneyFlowSettings.amount_inside_cash_register = quantity
    end
  end
end
